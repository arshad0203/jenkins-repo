pipeline {
  agent any

  environment {
    IMAGE_NAME = "arshadkhan0203/jenkins-docker"
    IMAGE_TAG = "${env.BUILD_NUMBER}"
    DOCKER_CREDENTIALS = 'dockerhubcred'
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Install & Test') {
      steps {
        sh 'npm ci'
        sh 'npm test'
      }
      post {
        always {
          junit 'test-results/*.xml'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
        }
      }
    }

    stage('Push to Docker Hub') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS}") {
            dockerImage.push("${IMAGE_TAG}")
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
          sh """
            docker rm -f my-ci-app || true
            docker pull ${IMAGE_NAME}:${IMAGE_TAG}
            docker run -d --name my-ci-app -p 8080:8080 ${IMAGE_NAME}:${IMAGE_TAG}
          """
        }
      }
    }
  }

  post {
    success { echo '✅ Pipeline completed successfully!' }
    failure { echo '❌ Pipeline failed!' }
  }
}
