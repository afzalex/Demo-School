FROM openjdk:11-jre-slim
COPY build/libs/eureka-server-0.0.1-SNAPSHOT.jar app.jar

ENV PORT=8311
ENV DATA_DIRECTORY=/appdata

EXPOSE 8311/tcp
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]