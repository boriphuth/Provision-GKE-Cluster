# Jenkins Dynamic Slave on Kubernetes

## Architecture
![](Jenkins.png)

## Setup
```bash
# 1. Setup Jenkins Deployment
kubectl create namespace jenkins
kubectl apply -f jenkins-master/deployment.yaml

# 2. Add Kubernetes Service Account and Role for Jenkins
kubectl create serviceaccount jenkins-master -n jenkins
kubectl apply -f jenkins-master/role.yaml

# 3. Add a Kubernetes Service to Access Jenkins
kubectl apply -f jenkins-master/service.yaml

# 4. Add Ingress
kubectl port-forward -n jenkins jenkins-master-bd9766598-wm4sb 8080:8080
kubectl apply -f jenkins-master/
```
## Helm 
i
```bash
kubectl create namespace jenkins
kubectl apply -f jenkins-master/jenkins-pv.yml
helm install jenkins stable/jenkins --namespace jenkins -f jenkins-master/values.yaml
printf $(kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
RFWEib0yFN
```

kubectl delete ns jenkins
kubectl create ns jenkins
gcloud compute images create jenkins-home-image --source-uri https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home-v3.tar.gz
gcloud compute disks create jenkins-home --image jenkins-home-image --zone=asia-southeast2-a
gcloud compute disks create jenkins-home --image jenkins-home-image --zone=asia-southeast2-b
gcloud compute disks create jenkins-home --image jenkins-home-image --zone=asia-southeast2-c
 [46] zone: asia-southeast2-a
 [47] zone: asia-southeast2-b
 [48] zone: asia-southeast2-c
PASSWORD=`openssl rand -base64 15`; echo "Your password is $PASSWORD"; sed -i.bak s#CHANGE_ME#$PASSWORD# k8s/options
kubectl create secret generic jenkins --from-file=k8s/options --namespace=jenkins
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value account)
kubectl create -f k8s/rbac.yaml
kubectl apply -f k8s/jenkins.yaml
kubectl apply -f k8s/service_jenkins.yaml
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=jenkins/O=jenkins"
kubectl create secret generic tls --from-file=/tmp/tls.crt --from-file=/tmp/tls.key --namespace jenkins
kubectl apply -f k8s/lb
kubectl get ingress --namespace jenkins

## Helm

kubectl delete ns jenkins
kubectl create ns jenkins
helm search hub jenkins
helm repo add jenkins https://charts.jenkins.io
helm repo update
kubectl config get-contexts
kubectl config set-context $(kubectl config current-context) --namespace=jenkins
cd jenkins
watch kubectl get all -n jenkins
# Helm 3
$ helm install [RELEASE_NAME] jenkins/jenkins [flags]
helm install jenkins -f values.yaml stable/jenkins -n jenkins

printf $(kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
watch kubectl get all
kubectl logs jenkins-54c9cb5465-xvdg4 -c jenkins -f

helm install cd-jenkins -f values.yaml stable/jenkins --version 1.7.3 --wait
kubectl get pods
kubectl create clusterrolebinding jenkins-deploy --clusterrole=cluster-admin --serviceaccount=default:cd-jenkins
export JENKINS_POD_NAME=$(kubectl get pods -l "app.kubernetes.io/component=jenkins-master" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $JENKINS_POD_NAME 8080:8080 >> /dev/null &
kubectl get svc
printf $(kubectl get secret cd-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
