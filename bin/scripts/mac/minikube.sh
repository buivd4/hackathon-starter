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

install(){
    # Main installation logic for macOS
    echo "[INFO] Attempting to install Minikube for macOS..."
    pre_install
    if [ $? -eq 0 ]; then
        # Check for Homebrew and install if not present
        if ! command -v brew &> /dev/null; then
            echo "[INFO] Homebrew is not installed. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install minikube
        post_install
        return 0
    fi
}
