pipeline {
    agent any  // Runs on your EC2 Jenkins agent

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhubcred'  // Your Jenkins Docker Hub credentials ID
        IMAGE_NAME = 'arshadkhan0203/jenkins-docker'
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/arshad0203/jenkins-repo.git', branch: 'main'
            }
        }

        stage('Install Dependencies & Test') {
            steps {
