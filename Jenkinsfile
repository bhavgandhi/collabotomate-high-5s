pipeline {
   agent any
   environment {
        GOOGLE_PROJECT_ID = "playground-s-11-6b335b"
    } 
   stages {
      stage("Stage 1 - Version Verification Stage") {
         steps {
            echo "Checking Versions..."
            sh "docker --version"
            sh "terraform version"
            sh "git version"
            sh "node -v"
            sh "npm -v"
            sh "gcloud version"
            
         }
      }
      stage("Stage 2 - Cloning GitHub Repo Into Jenkins...") {
         steps {
             git branch: "master",
                url:"https://github.com/bhavgandhi/collabotomate-high-5s.git"
             sh "ls"   
         }
      }
      stage("Stage 2.1 - NodeJS TEST...") {
         steps {
             sh "node --trace-deprecation"
             sh "npm install"
             sh "npm fund"
             // sh "npm test"
             sh "ls"   
         }
      }
      stage("Stage 3 - Package Application using Docker and storing the image in registry..") {
         steps {
            echo "Docker Images List"
            sh "docker images"
            echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
            sh "gcloud builds submit --tag=gcr.io/${GOOGLE_PROJECT_ID}/jenkins-pipe-external:v1.${env.BUILD_ID} . "
         }
      }
      stage("Stage 4 - Deployment - Kubernetes Cluster Resource Creation/Update") {
         steps {
            echo "Installing Kubernetes Cluster"
            sh "pwd"
            sh "ls"
            sh "gcloud container clusters get-credentials deloitte-drifters-demo-cluster --zone us-central1-a --project ${GOOGLE_PROJECT_ID}"
            
            sh "kubectl version"
            sh "kubectl get namespaces"
            
            echo "kubectl set image deployment/deloitte-drifters-frontend deloitte-drifters-frontend=gcr.io/${GOOGLE_PROJECT_ID}/jenkins-pipe-external:v1.${env.BUILD_ID} --record --namespace=master"
            sh "kubectl set image deployment/deloitte-drifters-frontend deloitte-drifters-frontend=gcr.io/${GOOGLE_PROJECT_ID}/jenkins-pipe-external:v1.${env.BUILD_ID} --record --namespace=master"
            
            sh "kubectl get deployments -n master"
            sh "kubectl get pods -n master"
            sh "kubectl get services -n master"
            
         }
      }
   }
   
}