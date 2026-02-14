# Utiliser une image Java 21
FROM eclipse-temurin:21-jdk-jammy

# Créer un répertoire de travail
WORKDIR /app

# Copier le JAR généré par Maven
COPY target/FlightHub-1.0-SNAPSHOT.jar app.jar

# Exposer le port (si votre app utilise un port)
EXPOSE 8080

# Commande pour lancer l'application
CMD ["java", "-jar", "app.jar"]
