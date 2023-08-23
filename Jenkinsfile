pipeline {
    agent any
    environment {
            DOCKERHUB_CREDENTIALS=credentials('dockerhub')    
    stages {
        stage('SonarQube analysis') {
            agent {
                docker {
                  image 'sonarsource/sonar-scanner-cli:4.7.0'
                }
               }
               environment {
        CI = 'true'
        //  scannerHome = tool 'Sonar'
        scannerHome='/opt/sonar-scanner'
    }
            steps{
                withSonarQubeEnv('Sonar') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        
        stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
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
}