env.BUILD_BRANCH = "master"
   env.BUILD_NAME = "devops/employee-microservice-node"
   env.CONTAINER_NAME = "devops/employee-microservice-nodenpminstall"
   env.DEPLOY_ENV = "DEPLOY"
   
    node() {
	
      stage('Checkout GIT Repository Master Branch') {
			
              checkout([$class: 'GitSCM', branches: [[name: "$BUILD_BRANCH"]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '0d7b9d79-2fed-416c-b033-99f5a99f21fd', url: 'https://github.com/harsimran498/employee-microservice-node.git']]])
}



stage('Run NPM Tests'){
      sh "npm install"
      sh "npm test "
     
  } 
  
  stage('Sonar Analysis with Sonar Scanner'){
      
      
 def scannerHome = tool 'Scanner'
      sh "cd ${workspace}"
      sh "${scannerHome}/bin/sonar-scanner"
  }
  

  stage("Runnning Quality Gate Step"){
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
            echo  "Quality Gate successfull"
        }
      }
	}


  stage('Docker Build '){
      def workspace = pwd () 
	  sh "echo $BUILD_NAME"
      sh "docker build -t $BUILD_NAME . "
	  
} 
  
    stage('Final Docker Build'){
      def workspace = pwd () 
      sh "docker build -t $CONTAINER_NAME -f Dockerfile_App . "
     } 
  
    stage('Creating Docker Container - Docker Run'){
      def workspace = pwd () 
      sh "chmod 777 remove.sh"
      sh "./remove.sh"
      sh "docker run -d -p 8002:8000 $CONTAINER_NAME"
      } 
  

def userInput
try {
    userInput = input(
        id: 'Proceed1', message: 'Are you Satisfied with results?', parameters: [
        [$class: 'BooleanParameterDefinition', defaultValue: true, description: '', name: 'Please confirm you want to push this build to Nexus Repository Manager for Docker']
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


stage ('Login to  Docker Nexus registry') {
sh "docker login -u admin -p admin123 34.73.184.207:8083" }

   stage ('Tag Docker Image') {
      	    sh "docker image tag $CONTAINER_NAME:latest 34.73.184.207:8083/$CONTAINER_NAME:$DEPLOY_ENV.${BUILD_NUMBER}"
      }

   stage ('Upload to Nexus') {
      	    sh "docker push 34.73.184.207:8083/$CONTAINER_NAME:$DEPLOY_ENV.${BUILD_NUMBER}"}
      	   
}
