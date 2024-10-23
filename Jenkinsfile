def GIT_COMMIT
def COMMIT_AUTHOR
pipeline {
    agent any
    stages {
        stage ('Checkout SCM'){
            steps {
                git (
                    branch: 'master',
                    credentialsId: 'gogs_int',
                    url: 'http://gogs:3000/gogs/hackathon-starter.git'
                )
                script {
                    GIT_COMMIT= sh (script: "git rev-parse HEAD ", returnStdout: true).trim() 
                    COMMIT_AUTHOR= sh (script: "git --no-pager show -s --format=\"%ae\"",returnStdout: true ).trim()
                }
            }
        }
        stage ('Unit Testing') {
            steps {
                sh "npm install"
                sh "npm test"
            }
        }
        stage ('Docker Image build') {
            steps {
                sh "docker build -t hackathon-starter:${GIT_COMMIT} . "
                sh "mkdir -p /tmp/hackathon-starter && docker save -o /tmp/hackathon-starter/hackathon-starter_${GIT_COMMIT}.tar hackathon-starter:${GIT_COMMIT}"
            }
        }
        stage ('Docker Image scan') {
            steps {
                script {
                    try {
                        sh "docker run -v /tmp/hackathon-starter/:/tmp/hackathon-starter aquasec/trivy image --exit-code 1 --severity CRITICAL,HIGH --input /tmp/hackathon-starter/hackathon-starter_${env.GIT_COMMIT}.tar"
                    } catch (Exception e) {
                        echo "tell ${COMMIT_AUTHOR}"
                        currentBuild.result = 'FAILURE'
                        unstable("The packaged docker image cannot pass the scan")
                    }
                }
            }
        }
        stage ('Docker Publish') {
            steps {
                sh "sh ./bin/build.sh -n hackathon-starter -t latest -r registry.docker.local:5001 -o"
            }
        }
        stage ('Deploy') {
            steps {
                sh "sh ./bin/deploy.sh"
            }
        }
        stage ('Clean up'){
            steps {
                sh "rm -rf /tmp/hackathon-starter/*"
            }
        }
    }
}