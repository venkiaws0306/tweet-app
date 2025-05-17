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
                sh "mvn compiler:compile"
            }
        }
            
        
        stage('build') {
            steps {
               sh "mvn package"
            }
        }
        
        stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarServer') { 
                  sh"${SCANNER_HOME}/bin/sonar-scanner-url"
                }
            }
        }
        
    }
}
