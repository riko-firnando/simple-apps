pipeline {
    agent { label 'server1-riko' }

    environment {
        SONAR_HOST_URL = 'http://192.168.56.1:9000'
        SONAR_LOGIN = 'sqp_712709226d51582d838b8bd813d9c31ca69f2543'
    }

    stages {
        stage('Pull SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        sh 'npm install'
                    } catch (Exception e) {
                        error "Build failed: ${e.getMessage()}"
                    }
                }
            }
        }

        stage('Testing') {
            steps {
                script {
                    try {
                        sh 'npm test && npm run test:coverage'
                    } catch (Exception e) {
                        error "Tests failed: ${e.getMessage()}"
                    }
                }
            }
        }

        stage('Code Review') {
            steps {
                script {
                    sh '''
                    export PATH=$PATH:/opt/sonar-scanner/bin
                    sonar-scanner \
                        -Dsonar.projectKey=simple-apps \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=$SONAR_HOST_URL \
                        -Dsonar.login=$SONAR_LOGIN
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker compose up --build -d'
            }
        }

        stage('Backup') {
            steps {
                script {
                    sh 'docker save -o simple-apps-backup.tar simple-apps'
                }
            }
        }
    }
}
