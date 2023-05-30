# Build stage
FROM quay.balgroupit.com/devops/certbundler:latest as certbundler
FROM registry.access.redhat.com/ubi8/openjdk-17 AS build
COPY --from=certbundler /app/certbundler /app/certbundler
USER root
RUN /app/certbundler && rm -f /app/certbundler
COPY --chown=jboss:jboss / /usr/local/src/prometheus-training-spring-boot-example
ENV http_proxy="host.docker.internal:8888"
ENV https_proxy="host.docker.internal:8888"
ENV MAVEN_OPTS='-Dhttp.proxyHost=host.docker.internal -Dhttp.proxyPort=8888 -Dhttps.proxyHost=host.docker.internal -Dhttps.proxyPort=8888 -Dhttp.nonLocalHosts="balgroupit.com|localhost|127.*|[::1]"'
RUN cd /usr/local/src/prometheus-training-spring-boot-example && \
    ./mvnw clean package


# Package stage
FROM registry.access.redhat.com/ubi8/openjdk-17
COPY --chown=jboss:jboss --from=build /usr/local/src/prometheus-training-spring-boot-example/target/prometheus-training-spring-boot-example-0.0.1-SNAPSHOT.jar /usr/local/bin/prometheus-training-spring-boot-example.jar
RUN chgrp -R 0 /usr/local/bin/prometheus-training-spring-boot-example.jar && \
chmod -R g+rwX /usr/local/bin/prometheus-training-spring-boot-example.jar
ENTRYPOINT ["java","-jar","/usr/local/bin/prometheus-training-spring-boot-example.jar"]
EXPOSE 8080/tcp
