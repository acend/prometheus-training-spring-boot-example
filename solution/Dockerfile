
# Build stage
FROM registry.access.redhat.com/ubi8/openjdk-17 AS build
COPY --chown=jboss:jboss / /usr/local/src/prometheus-training-spring-boot-example
RUN cd /usr/local/src/prometheus-training-spring-boot-example && ./mvnw clean package
RUN curl -L https://github.com/prometheus/prometheus/releases/download/v2.41.0/prometheus-2.41.0.linux-amd64.tar.gz \
     --output /tmp/prometheus-2.41.0.linux-amd64.tar.gz && tar xzf /tmp/prometheus-2.41.0.linux-amd64.tar.gz -C /home/jboss prometheus-2.41.0.linux-amd64/promtool
RUN find /home/jboss

# Package stage
FROM registry.access.redhat.com/ubi8/openjdk-17
COPY --from=build /usr/local/src/prometheus-training-spring-boot-example/target/prometheus-training-spring-boot-example-0.0.1-SNAPSHOT.jar /usr/local/bin/prometheus-training-spring-boot-example.jar
COPY --from=build /home/jboss/prometheus-2.41.0.linux-amd64/promtool /usr/local/bin/promtool
RUN chgrp -R 0 /usr/local/bin/prometheus-training-spring-boot-example.jar /usr/local/bin/promtool && \
    chmod -R g+rwX /usr/local/bin/prometheus-training-spring-boot-example.jar /usr/local/bin/promtool
ENTRYPOINT ["java","-jar","/usr/local/bin/prometheus-training-spring-boot-example.jar"]
EXPOSE 8080/tcp
