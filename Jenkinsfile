    node() {
	
	
	
      stage('Checkout') {
			
              checkout([$class: 'GitSCM', branches: [[name: "master"]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '	ff27d625-f3c0-4d1a-84c1-931efe2f8fbd', url: 'https://github.com/harsimran498/employee-microservice-node.git']]])
}



stage('NPM test'){
      sh "npm install"
      sh "npm test "
     
  } 
  
  stage('sonar analysis with sonar scanner'){
      def scannerHome = tool 'Scanner'
      sh "cd ${workspace}"
      sh "${scannerHome}/bin/sonar-scanner"
     }
  

  stage("Quality Gate"){
	  sh "sleep 30s"
      withSonarQubeEnv('sonarqube') {
        env.SONAR_CE_TASK_URL = sh(returnStdout: true, script: """cat ${workspace}/.scannerwork/report-task.txt|grep -a 'ceTaskUrl'|awk -F '=' '{print \$2\"=\"\$3}'""")
        timeout(time: 1, unit: 'MINUTES') {
            sh 'curl $SONAR_CE_TASK_URL -o ceTask.json'
            env.analysisID = sh(returnStdout: true, script: """cat ceTask.json |awk -F 'analysisId' '{print \$2}'|awk -F ':' '{print \$2}'|awk -F '\"' '{print \$2}'""")
            sh "echo $analysisID"
            println(analysisID)
            env.qualityGateUrl = env.SONAR_HOST_URL + "/api/qualitygates/project_status?analysisId=" + env.analysisID
            sh 'curl $SONAR_AUTH_TOKEN $qualityGateUrl -o qualityGate.json'
            env.qualitygate = sh(returnStdout: true, script: """cat qualityGate.json |awk -F 'status' '{print \$2}'|awk -F ':' '{print \$2}'|awk -F '\"' '{print \$2}'""")
            if (qualitygate.trim().equals("ERROR")) {
              error  "Quality Gate failure"
            }
            echo  "Quality Gate success"
        }
      }
	}



  stage('Docker Build'){
      def workspace = pwd () 
      sh "docker build -t devops/employee-microservice-node . "
} 
  
  
    stage('Docker Build'){
      def workspace = pwd () 
      sh "docker build -t devops/employee-microservice-nodenpminstall -f Dockerfile_App . "
     } 
  
    stage('Docker Run'){
      def workspace = pwd () 
      sh "docker run -d -p 8002:8000 devops/employee-microservice-nodenpminstall"
      }
  

def userInput
try {
    userInput = input(
        id: 'Proceed1', message: 'Was this successful?', parameters: [
        [$class: 'BooleanParameterDefinition', defaultValue: true, description: '', name: 'Please confirm you want to push this build to repo']
        ])
} catch(err) { // input false
    def user = err.getCauses()[0].getUser()
    userInput = false
    echo "Aborted by: [${user}]"
}

node {
    if (userInput == true) {
        // do something
        echo "this was successful"
    } else {
        // do something else
        echo "this was not successful"
        currentBuild.result = 'FAILURE'
    } 
} 

/** to tag the image */

   stage ('Tag Docker Image') {
      	    sh "docker image tag devops/employee-microservice-nodenpminstall:latest 34.73.184.207:8083/employee-microservice-nodenpminstall:Dev.${BUILD_NUMBER}"
      }

   stage ('Upload to Nexus') {
      	    sh "docker push 34.73.184.207:8083/employee-microservice-nodenpminstall:Dev.${BUILD_NUMBER}"}
}
