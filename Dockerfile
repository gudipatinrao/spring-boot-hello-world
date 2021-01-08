FROM openjdk:14-jdk-alpine

COPY /target/spring-boot-helloworld-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
ARG VERBOSE=true



