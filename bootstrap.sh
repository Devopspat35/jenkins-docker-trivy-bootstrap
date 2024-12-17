#!/bin/bash
sudo -i
sudo hostnamectl set-hostname  jenkins
sudo timedatectl set-timezone America/New_York
sudo apt update -y
sudo apt install tree nano dnf git wget rpm vim -y
sudo apt install net-tools -y
sudo su - ubuntu
sudo apt remove java* -y
sudo apt install openjdk-17-jre-headless -y
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
sudo systemctl start docker
sudo systemctl enable docker
#create jenkinsusere
sudo adduser jenkins
sudo passwd jenkins <<EOF
foncha
EOF
sudo echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins
#install jenkins on ubuntu
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
# Add required dependencies for the jenkins package
sudo dnf install jenkins -y
sudo systemctl daemon-reload
#start and eneble docker engine
sudo systemctl enable jenkins
sudo systemctl start jenkins
#navigate to the opt/
cd /opt
sudo apt install nodejs npm -y
#inatall trivy image scan tool
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy



