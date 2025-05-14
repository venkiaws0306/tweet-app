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
   
        stage('build') {
            steps {
               sh "mvn package"
            }
        }
       

        
   } 
}


