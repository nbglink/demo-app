FROM openjdk:8u171-alpine3.7
COPY target/*.jar demo-app.jar
CMD java ${JAVA_OPTS} -jar demo-app.jar