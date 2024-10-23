#!/bin/bash

# Function to check if Docker is already installed
pre_install() {
  if command -v docker &> /dev/null; then
    echo "[INFO] Docker is already installed. Skipping ..."
    return 1
  else
    return 0
  fi
}

# Function to validate Docker installation
post_install() {
  if command -v docker &> /dev/null; then
    echo "[INFO] Installed Docker successfully"
    return 0
  else
    echo "[ERROR] Installation of Docker was not successful"
    exit 1
  fi
}

install() {
    echo "[INFO] Attempting to install Docker ..."
    pre_install
    if [ $? -eq 0 ]; then
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        sudo yum install -y docker-ce
        sudo systemctl start docker
        sudo systemctl enable docker
        post_install
        return 0
    fi
}
