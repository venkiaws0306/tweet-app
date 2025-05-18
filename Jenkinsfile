def registry = 'https://trialz4ixqj.jfrog.io'

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

     stage("Quality Gate"){
	steps {
		script {
				timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
			def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
			if (qg.status != 'OK') {
			  error "Pipeline aborted due to quality gate failure: ${qg.status}"
			}
		  }
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

	    

	    
        
    }
}
