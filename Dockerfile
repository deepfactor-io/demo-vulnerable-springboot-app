FROM openjdk:8-jdk as BUILD

RUN mkdir /workspace
WORKDIR /workspace
COPY . .

RUN ./gradlew build

FROM openjdk:8-jre as APP

#RUN apt update && apt install -y netcat


EXPOSE 8080

COPY --from=BUILD /workspace/build/libs/*.jar demo-vulnerable-springboot-app.jar

ENV SECRETKEY="$DFSCAN_TOKEN"
ENV DF_MONITOR_EXEC="true"

ENTRYPOINT ["java", "-jar", "./demo-vulnerable-springboot-app.jar"]
