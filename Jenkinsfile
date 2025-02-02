pipeline {
    agent { label 'server1-riko' }

    stages {
        stage('Pull SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/riko-firnando/simple-apps.git'
            }
        }
        
        stage('Build & Test') {
            steps {
                sh '''
                pwd
                ls -l
                [ -d "apps" ] || { echo "Directory 'apps' not found!"; exit 1; }
                cd apps
                npm install
                npm test
                npm run test:coverage
                '''
            }
        }
        
        stage('Code Review') {
            steps {
                sh '''
                pwd
                ls -l
                [ -d "apps" ] || { echo "Directory 'apps' not found!"; exit 1; }
                cd apps
                sonar-scanner \
                    -Dsonar.projectKey=simple-apps \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://192.168.56.1:9000 \
                    -Dsonar.login=sqp_712709226d51582d838b8bd813d9c31ca69f2543
                '''
            }
        }
        
        stage('Deploy & Backup') {
            steps {
                sh '''
                pwd
                ls -l
                docker compose up --build -d
                '''
            }
        }
    }
}
