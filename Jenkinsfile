pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'java -jar target/myapp.jar'
            }
        }
    }
    
    post {
        always {
            cleanWs() // Clean workspace after the pipeline finishes
        }
    }
}
