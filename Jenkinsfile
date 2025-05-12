pipeline {
    agent any
    tools {
            maven 'maven3'
        }
    stages {
         stage('complile') {
                    steps {
                        bat "mvn compiler:compile"
                    }
                }
        stage('Build') {
                    steps {
                        bat "mvn clean deploy"
                    }
                }
    }
}


