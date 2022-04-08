FROM openjdk:11-jre-slim
COPY build/libs/eureka-server-0.0.1-SNAPSHOT.jar app.jar
ENV PORT=7311
EXPOSE 7311/tcp
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]