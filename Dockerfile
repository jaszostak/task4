# ---- Build Stage ----
FROM maven:3.9-eclipse-temurin-11 AS build

WORKDIR /app

# Copy the source code to the container
COPY pom.xml /app/
COPY src /app/src

# Package the application
RUN mvn clean install -DskipTests

# ---- Deploy Stage ----
FROM eclipse-temurin:11-jre

# Copy the built JAR from the build stage
COPY --from=build /app/target/thymeleaf-0.0.1-SNAPSHOT.jar /app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]
