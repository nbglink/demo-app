FROM openjdk:8u171-alpine3.7

EXPOSE 9090

COPY ./target/demo-app-0.0.1-SNAPSHOT.jar /usr/app/
WORKDIR /usr/app

ENTRYPOINT ["java", "-jar", "demo-app-0.0.1-SNAPSHOT.jar"]