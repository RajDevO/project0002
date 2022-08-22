pipeline{
    agent any
    tools {
        maven 'mvn'
    }
    stages {
        stage('Build Maven') {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '2e870c5a-54bb-4f34-94a1-586d17a32b58', url: 'https://github.com/RajDevO/project0002.git']]])
                sh "mvn install"
                sh "mvn package -Pproduction"
                
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                  sh 'docker build -t kuberaj/project002 .'
                }
            }
        }
        stage('Docker Image Push: DockerHub') {
            steps {
                script {
                 withCredentials([string(credentialsId: 'kuberaj', variable: 'dockerhub')]) {
                    sh 'docker login -u kuberaj -p ${dockerhub}'
                 }  
                 sh 'docker push kuberaj/project002'
                }
            }
        }
        
        stage('Helm-chart deployment on KOPS'){
            agent{label 'KOPS'}
                steps{
                    sh "sudo su"
                    sh "cd /opt/jenkins-slave/workspace/ && rm -rf project0002 && git clone https://github.com/RajDevO/project0002.git"
                    sh "cd /opt/jenkins-slave/workspace/project0002"
                    sh "helm upgrade --install --force myhelm k8s-chart --set appimage=kuberaj/project002:latest --namespace prod"
                    }
            }

        }
        
    }
