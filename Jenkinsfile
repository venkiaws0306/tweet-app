pipeline {
    agent any
    
    tools {
        maven 'maven3'
    }
    
    environment{
        SCANNER_HOME = tool 'sonar-scanner-url'
    }

    stages {
        stage('Git checkout/SCM') {
            steps {
                 git branch: 'main', url: 'https://github.com/venkiaws0306/tweet-app.git'
            }
        }
        
        stage('complile') {
            steps {
                bat "mvn compiler:compile"
            }
        }
        
        stage('test') {
            steps {
                bat "mvn test"
            }
        }
        
        stage('build') {
            steps {
               bat "mvn package"
            }
        }
        
        stage('SonarQube analysis') {
            withSonarQubeEnv('my sonarqube serverURL') { // You can override the credential to be used, If you have configured more than one global server connection, you can specify the corresponding SonarQube installation name configured in Jenkins
              sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.11.0.3922:sonar'
                sh"${SCANNER_HOME}/bin/sonar-scanner-url"
            }
        }
        
    }
}
