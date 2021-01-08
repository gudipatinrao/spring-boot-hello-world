FROM openliberty/open-liberty:kernel-slim-java8-ibmjava-ubi as staging
USER 0
RUN features.sh
COPY --chown=1001:0 ./target/spring-boot-data-jpa-0.0.1-SNAPSHOT.jar /staging/fatClinic.jar

RUN springBootUtility thin \
 --sourceAppPath=/staging/fatClinic.jar \
 --targetThinAppPath=/staging/thinClinic.jar \
 --targetLibCachePath=/staging/lib.index.cache

FROM openliberty/open-liberty:kernel-slim-java8-ibmjava-ubi
USER 0
RUN features.sh
COPY --from=staging /staging/lib.index.cache /opt/ol/wlp/usr/shared/resources/lib.index.cache
COPY --from=staging /staging/thinClinic.jar /config/dropins/spring/thinClinic.jar
ARG VERBOSE=true
RUN configure.sh


