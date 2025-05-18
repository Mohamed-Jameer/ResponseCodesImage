# Use Maven to build the app
FROM maven:3.8-openjdk-17 AS build

# Set working directory
WORKDIR /app

# Copy all files to the image
COPY . .

# Build the project, skipping tests
RUN mvn clean package -DskipTests

# Use JDK 17 slim image to run the app
FROM openjdk:17-slim

# Set working directory
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose port (e.g., 8080)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
