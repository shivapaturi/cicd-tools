#!/bin/bash

#resize disk from 20GB to 50GB
growpart /dev/nvme0n1 4

lvextend -L +10G /dev/RootVG/homeVol
lvextend -L +10G /dev/mapper/RootVG-varVol
lvextend -l +100%FREE /dev/mapper/RootVG-varTmpVol

xfs_growfs /
xfs_growfs /var/tmp
xfs_growfs /var


#!/bin/bash

dnf install -y fontconfig java-21-openjdk curl

# Add Jenkins stable repository
curl -fsSL https://pkg.jenkins.io/rpm-stable/jenkins.repo \
  -o /etc/yum.repos.d/jenkins.repo

# Import Jenkins signing key
rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2026.key

# Install Jenkins
dnf clean all
dnf makecache
dnf install -y jenkins

# Start Jenkins
systemctl daemon-reload
systemctl enable --now jenkins

# Verify
systemctl status jenkins --no-pager