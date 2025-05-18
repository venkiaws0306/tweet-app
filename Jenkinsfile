def registry = 'https://trialz4ixqj.jfrog.io'
def imageName = 'trialz4ixqj.jfrog.io/galaxy-docker-local/ttrend'
def version   = '2.1.2'

pipeline {
    agent any
    
    tools {
        maven 'maven3'
    }
    
    environment{
        SCANNER_HOME = tool 'sonar-scanner-url'
	DOCKER_IMAGE_NAME = 'venkiaws/ttrend'
        DOCKER_IMAGE_TAG = '2.1.2'
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

    

stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"Jenkins-access-token"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   
    }

 stage('Build Docker Image') {
            steps {
                script {
                    def imageTag = "${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}"
                    sh "docker build -t ${imageTag} ."
                }
            }
        }

        stage('Docker Login and Push Image') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'docker-cred',
                        usernameVariable: 'DOCKER_HUB_CREDENTIALS_USR',
                        passwordVariable: 'DOCKER_HUB_CREDENTIALS_PSW'
                    )]) {
                        sh "echo ${DOCKER_HUB_CREDENTIALS_PSW} | docker login -u ${DOCKER_HUB_CREDENTIALS_USR} --password-stdin"
                        def imageTag = "${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}"
                        sh "docker push ${imageTag}"
                    }
                }
            }
        }
	    

	    
        
    }
}
