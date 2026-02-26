FROM ubuntu:22.04

# Installer Java 21
RUN apt-get update && \
    apt-get install -y openjdk-21-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Spring Boot JAR (nom différent !)
COPY target/devops-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
