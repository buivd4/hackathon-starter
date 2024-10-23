#!/bin/bash

# Function to check if Minikube is already installed
pre_install() {
  if command -v minikube &> /dev/null; then
    echo "[INFO] Minikube is already installed. Skipping ..."
    return 1
  else
    return 0
  fi
}

# Function to validate Minikube installation
post_install() {
  if command -v minikube &> /dev/null; then
    echo "[INFO] Installed Minikube successfully"
    return 0
  else
    echo "[ERROR] Installation of Minikube was not successful"
    exit 1
  fi
}

install() {
    # Main installation logic for RHEL
    echo "[INFO] Attempting to install Minikube for RHEL..."
    pre_install
    if [ $? -eq 0 ]; then
        sudo yum install -y curl
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        sudo install minikube-linux-amd64 /usr/local/bin/minikube
        post_install
        return 0
    fi
}
