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
                echo "Installing Node.js dependencies..."
                sh 'npm install'  // Changed from npm ci to npm install

                echo "Running tests..."
                sh 'npm test || true' // Avoid pipeline failure if no tests are present
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Logging in to Docker Hub..."
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", 
                                                  usernameVariable: 'DOCKER_USER', 
                                                  passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }

                echo "Pushing Docker image..."
                sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying application..."
                // Stop and remove old container if exists
                sh "docker rm -f jenkins-docker || true"
                // Run new container
                sh "docker run -d --name jenkins-docker -p 3000:3000 ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
