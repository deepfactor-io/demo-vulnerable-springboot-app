FROM openjdk:8-jdk as BUILD

RUN mkdir /workspace
WORKDIR /workspace
COPY . .

RUN ./mvnw package

FROM openjdk:8-jre as APP

EXPOSE 8080

COPY --from=BUILD /workspace/target/*.jar damn-vulnerable-spring-boot-app.jar

ENTRYPOINT ["java", "-jar", "./damn-vulnerable-spring-boot-app.jar"]
