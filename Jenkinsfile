pipeline {
   agent any

   stages {
      stage('Version Verification Stage') {
         steps {
            echo 'Checking Versions...'
            sh 'docker --version'
            sh 'terraform version'
            sh 'git version'
            sh 'node -v'
            sh 'npm -v'
            sh 'gcloud version'
            
         }
      }
      stage('Cloning GitHub Repo Into Jenkins...') {
         steps {
             git branch: "dev",
                url:'https://github.com/mkumarroy1991/devops-demo-external.git'
             sh 'ls'   
         }
      }
      
      stage('Package Application using Docker and storing the image in registry..') {
         steps {
            echo 'Docker Images List'
            sh 'docker images'
            echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
            sh "gcloud builds submit --tag=gcr.io/playground-s-11-58cd9c/jenkins-pipe-external:v1.${env.BUILD_ID} . "
         }
      }
      stage('Deployment - Kubernetes Cluster Resource Creation/Update') {
         steps {
            echo 'Installing Kubernetes Cluster'
            sh 'pwd'
            sh 'ls'
            sh 'gcloud container clusters get-credentials deloitte-drifters-demo-cluster --zone us-central1-a --project playground-s-11-58cd9c'
            
            sh 'kubectl version'
            sh 'kubectl get namespaces'
            
            echo 'kubectl set image deployment/deloitte-drifters-frontend deloitte-drifters-frontend=gcr.io/playground-s-11-58cd9c/jenkins-pipe-external:v1.${env.BUILD_ID} --record --namespace=dev'
            sh "kubectl set image deployment/deloitte-drifters-frontend deloitte-drifters-frontend=gcr.io/playground-s-11-58cd9c/jenkins-pipe-external:v1.${env.BUILD_ID} --record --namespace=dev"
            
            sh 'kubectl get deployments -n dev'
            sh 'kubectl get pods -n dev'
            sh 'kubectl get services -n dev'
            
         }
      }
   }
   
}
