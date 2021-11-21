FROM openjdk:11.0-jdk-slim
EXPOSE 80 8080
COPY build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
