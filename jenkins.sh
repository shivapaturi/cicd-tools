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

set -e

# Install Java 21 and dependencies
sudo yum install -y fontconfig java-21-openjdk curl

# Add Jenkins stable repository
sudo curl -fsSL \
  https://pkg.jenkins.io/rpm-stable/jenkins.repo \
  -o /etc/yum.repos.d/jenkins.repo

# Import Jenkins signing key
sudo rpm --import \
  https://pkg.jenkins.io/rpm-stable/jenkins.io-2026.key

# Install Jenkins
sudo yum clean all
sudo yum install -y jenkins

# Enable and start Jenkins
sudo systemctl daemon-reload
sudo systemctl enable --now jenkins

# Verify installation
sudo systemctl status jenkins --no-pager
java -version
