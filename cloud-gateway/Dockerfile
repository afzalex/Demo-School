FROM openjdk:11-jre-slim
COPY build/libs/cloud-gateway-0.0.1-SNAPSHOT.jar app.jar

ENV PORT=8310
ENV CONFIG_SERVER_URI=http://config-server:8312/
ENV EUREKA_SERVER_URI=http://eureka-server:8311/eureka
ENV DATA_DIRECTORY=/appdata

EXPOSE 8310/tcp
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]