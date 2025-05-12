pipeline {
    agent any
    tools {
            maven 'maven3'
        }
    
    stages {
         stage('complile') {
                    steps {
                        sh "mvn compiler:compile"
                    }
                }
   
         stage('Build') {
                    steps {
                        sh "mvn clean package"
                    }
                }

        
          } 
}


