pipeline {
    agent {
        node {
            label 'k8s'
        }
    }
 //   triggers {
 //       pollSCM('* * * * *')
 //   }
    environment{
        DOCKER_TAG = getDockerTag()
    }

    stages{

        stage('Build Image'){
            steps{
                sh "docker build -f Dockerfile-API . -t registry.com:5000/test:${DOCKER_TAG}"
            }
        }

        stage('Push Image'){
            steps{
  //        withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerHubPwd')]) {
  //            sh "docker login -u rokonzaman -p ${dockerHubPwd}"
                sh "docker push registry.com:5000/test:${DOCKER_TAG}"
 //            }
        }
    }

        stage('Remove Image'){
            steps{
                sh "docker rmi registry.com:5000/test:${DOCKER_TAG}"
            }
        }

        stage('Deploy to k8s'){
            steps{
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
                sh " kubectl apply -f test-dep.yaml-tag.yaml"
            }
        }
    }
}

//
def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
