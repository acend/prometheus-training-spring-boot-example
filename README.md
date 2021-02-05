# prometheus-training-spring-boot-example

This is a spring boot example project to show the prometheus client lib instrumentation in springboot

It consists of two spring boot applications

* the skeleton for the lab in the source folder
* the solution in the solution folder

## Lab

### Build

```bash
./mvnw clean package
```

### Run

```bash
java -jar target/prometheus-training-spring-boot-example-0.0.1-SNAPSHOT.jar
```

### Verify Prometheus Metrics

```bash
curl http://localhost:8080/actuator/prometheus
```

### Custom Metric

```bash
curl http://localhost:8080/api
```
