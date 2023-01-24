FROM adoptopenjdk/openjdk11:x86_64-ubuntu-jre-11.0.18_10

EXPOSE 9090

COPY ./target/demo-app-0.0.1-SNAPSHOT.jar /usr/app/
WORKDIR /usr/app

ENTRYPOINT ["java", "-jar", "demo-app-0.0.1-SNAPSHOT.jar"]