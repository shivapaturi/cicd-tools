#!/bin/bash

#resize disk from 20GB to 50GB
growpart /dev/nvme0n1 4

#  Extend logical volumes
lvextend -L +10G /dev/RootVG/homeVol
lvextend -L +10G /dev/RootVG/varVol
lvextend -l +100%FREE /dev/RootVG/varTmpVol

#  Grow XFS filesystems
xfs_growfs /home
xfs_growfs /var
xfs_growfs /var/tmp

curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum install fontconfig java-21-openjdk -y
yum install jenkins -y
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
