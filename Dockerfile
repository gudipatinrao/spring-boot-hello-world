FROM openliberty/open-liberty:kernel-slim-java8-ibmjava-ubi as staging
USER 0

RUN features.sh

COPY --chown=1001:0 ./target/spring-boot-helloworld-0.0.1-SNAPSHOT.jar /config/dropins/spring/thinClinic.jar

ARG VERBOSE=true
RUN configure.sh


