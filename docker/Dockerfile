FROM openjdk:11-jre
RUN mkdir app
ADD boleto-api.jar /app/boleto-api.jar
WORKDIR /app
ENTRYPOINT java -jar boleto-api.jar