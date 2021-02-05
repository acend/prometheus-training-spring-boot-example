package ch.acend.prometheustrainingspringbootexample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.MeterRegistry;

@RestController
public class CustomMetricController {

	private final Counter myCounter;
	private final MeterRegistry meterRegistry;

	@Autowired
	public CustomMetricController(MeterRegistry meterRegistry) {
		this.meterRegistry = meterRegistry;
		this.myCounter = meterRegistry.counter("my.prometheus.instrumentation.counter");
	}

	@GetMapping(value = "/api")
	public String getAll() {
		myCounter.increment();
		return "ok";
	}
}
