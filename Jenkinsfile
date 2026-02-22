pipeline {
    agent any
    
    tools {
        maven 'Maven'
        jdk 'JAVA_HOME'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '===== Récupération du code depuis GitHub ====='
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo '===== Compilation avec Maven ====='
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                echo '===== Exécution des tests ====='
                sh 'mvn test'
            }
        }
        
        stage('SONARQUBE') {
            environment {
                SONAR_HOST_URL = 'http://192.168.56.101:9000/'
                SONAR_AUTH_TOKEN = credentials('sonarqube')
            }
            steps {
                echo '===== Analyse qualité du code avec SonarQube ====='
                sh 'mvn sonar:sonar -Dsonar.projectKey=flighthub -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_AUTH_TOKEN'
            }
        }
        
        stage('Package') {
            steps {
                echo '===== Création du JAR ====='
                sh 'mvn package -DskipTests'
            }
        }
        
        stage('Docker Build') {
            steps {
                echo '===== Construction de l image Docker ====='
                sh 'docker build -t eyagharby/flighthub:${BUILD_NUMBER} .'
            }
        }
        
        stage('Docker Push') {
            steps {
                echo '===== Push vers Docker Hub ====='
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push eyagharby/flighthub:${BUILD_NUMBER}'
                }
            }
        }
    }
    
    post {
        success {
            echo '✓ BUILD ET DÉPLOIEMENT DOCKER RÉUSSIS !'
        }
        failure {
            echo '✗ BUILD ÉCHOUÉ !'
        }
    }
}
