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
        
        stage('Package') {
            steps {
                echo '===== Création du JAR ====='
                sh 'mvn package -DskipTests'
            }
        }
        
        stage('Docker Build') {
            steps {
                echo '===== Construction de l image Docker ====='
                sh 'docker build -t eyaa54/flighthub:${BUILD_NUMBER} .'
            }
        }
        
        stage('Docker Push') {
            steps {
                echo '===== Push vers Docker Hub ====='
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push eyaa54/flighthub:${BUILD_NUMBER}'
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
