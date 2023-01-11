
# Build stage
FROM registry.access.redhat.com/ubi8/openjdk-17 AS build
COPY --chown=jboss:jboss / /usr/local/src/prometheus-training-spring-boot-example
RUN cd /usr/local/src/prometheus-training-spring-boot-example && ./mvnw clean package

# Package stage
FROM registry.access.redhat.com/ubi8/openjdk-17
COPY --from=build /usr/local/src/prometheus-training-spring-boot-example/target/prometheus-training-spring-boot-example-0.0.1-SNAPSHOT.jar /usr/local/bin/prometheus-training-spring-boot-example.jar
RUN chgrp -R 0 /usr/local/bin/prometheus-training-spring-boot-example.jar && \
    chmod -R g+rwX /usr/local/bin/prometheus-training-spring-boot-example.jar
ENTRYPOINT ["java","-jar","/usr/local/bin/prometheus-training-spring-boot-example.jar"]
EXPOSE 8080/tcp
