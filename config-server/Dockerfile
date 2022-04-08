FROM openjdk:11-jre-slim
COPY build/libs/config-server-0.0.1-SNAPSHOT.jar app.jar
ENV PORT=7312
EXPOSE 7312/tcp
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]