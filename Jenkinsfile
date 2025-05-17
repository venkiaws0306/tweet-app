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
        
        stage('test') {
            steps {
                 echo "-----------------------Unit Test started -----------------"
				 sh "mvn surefire-report:report"
			     echo "-----------------------Unit Test completed -----------------"
            }
        }
        
             
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarServer') {
                    // Use backslashes and .bat for Windows
                    bat "\"${env.SCANNER_HOME}\\bin\\sonar-scanner.bat\""
                }
            }
        }
    
        
    }
}
