# Stage 1: Build with Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application with JDK
FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
COPY --from=build /app/WeChat/target/WeChat.jar ./WeChat.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "WeChat.jar"]
