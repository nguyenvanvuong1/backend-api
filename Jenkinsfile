pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 486786740148.dkr.ecr.ap-southeast-1.amazonaws.com
                docker build -t 486786740148.dkr.ecr.ap-southeast-1.amazonaws.com/sd4776-dev-app1:${BUILD_NUMBER} .
                docker push 486786740148.dkr.ecr.ap-southeast-1.amazonaws.com/sd4776-dev-app1:${BUILD_NUMBER}
            }
        }
    }
}