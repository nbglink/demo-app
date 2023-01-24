FROM openjdk:8u171-alpine3.7

EXPOSE 9090

COPY ./target/java-maven-app-0.0.1-SNAPSHOT.jar /usr/app/
WORKDIR /usr/app

ENTRYPOINT ["java", "-jar", "java-maven-app-0.0.1-SNAPSHOT.jar"]