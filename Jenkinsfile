// Define variables
def scmVars

// Start Pipeline
pipeline {

  // Configure Jenkins Slave
  agent {
    // Use Kubernetes as dynamic Jenkins Slave
    kubernetes {
      // Kubernetes Manifest File to spin up Pod to do build
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:19.03.13-dind
    command:
    - dockerd
    - --host=unix:///var/run/docker.sock
    - --host=tcp://0.0.0.0:2375
    - --storage-driver=overlay2
    tty: true
    securityContext:
      privileged: true
  - name: helm
    image: lachlanevenson/k8s-helm:v3.3.4
    command:
    - cat
    tty: true
"""
    } // End kubernetes
  } // End agent

  // Define Environment Variables
  environment {
    ENV_NAME = "${BRANCH_NAME == "master" ? "uat" : "${BRANCH_NAME}"}"
  }

  // Start Pipeline
  stages {

    // ***** Stage Clone *****
    stage('Clone ratings source code') {
      // Steps to run build
      steps {
        // Run in Jenkins Slave container
        container('jnlp') {
          // Use script to run
          script {
            // Git clone repo and checkout branch as we put in parameter
            scmVars = git branch: "${BRANCH_NAME}",
                          credentialsId: 'training3-bookinfo-git-deploy-key',
                          url: 'git@git.demo.opsta.co.th:dfd-3/training3/ratings.git'
          } // End script
        } // End container
      } // End steps
    } // End stage

    // ***** Stage Build *****
    stage('Build ratings Docker Image and push') {
      steps {
        container('docker') {
          script {
            // Do docker login authentication
            docker.withRegistry('https://registry.demo.opsta.co.th', 'registry-bookinfo') {
              // Do docker build and docker push
              docker.build("registry.demo.opsta.co.th/training3/bookinfo/ratings:${ENV_NAME}").push()
            } // End docker.withRegistry
          } // End script
        } // End container
      } // End steps
    } // End stage

    // ***** Stage Deploy *****
    stage('Deploy ratings with Helm Chart') {
      steps {
        // Run on Helm container
        container('helm') {
          script {
            // Use kubeconfig from Jenkins Credential
            withKubeConfig([credentialsId: 'gce-k8s-kubeconfig']) {
              // Run Helm upgrade
              sh "helm upgrade -f k8s/helm-values/values-bookinfo-${ENV_NAME}-ratings.yaml --wait \
                --set extraEnv.COMMIT_ID=${scmVars.GIT_COMMIT} \
                --namespace training3-bookinfo-${ENV_NAME} bookinfo-${ENV_NAME}-ratings k8s/helm"
            } // End withKubeConfig
          } // End script
        } // End container
      } // End steps
    } // End stage

  } // End stages
} // End pipeline
