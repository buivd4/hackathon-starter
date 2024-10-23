#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Define required packages for each OS, the order is matter ---
MACOS_PACKAGES=(
    "xcode" "nodejs" "docker" 
    "minikube" )

DEBIAN_PACKAGES=(
    "build-essential" "nodejs" "docker"
    "minikube" )

RHEL_PACKAGES=(
    "build-essential" "nodejs" "docker"
    "minikube" )


set_os() {
  # Check the operating system
  # 1 - windows
  # 2 - macos
  # 3 - debian linux
  # 4 - rhel linux

  if [[ "$OSTYPE" == "msys"* ]]; then
    return 0
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    packages=("${MACOS_PACKAGES[@]}")
    os="mac"
  elif [[ "$OSTYPE" == "linux"* ]]; then
    if [ -f /etc/debian_version ]; then
        packages=("${DEBIAN_PACKAGES[@]}")
        os="debian"
    elif [ -f /etc/redhat-release ]; then
        packages=("${RHEL_PACKAGES[@]}")
        os="rhel"
    fi
  fi
  if [[ "$os" == "unknown" ]]; then
    echo "Unsupported operating system"
    exit -1
  fi
}

load_script() {
    os=$1
    script=$2
    echo "[INFO] Loading script to install $script at $SCRIPT_DIR/scripts/$os/$script.sh"
    . $SCRIPT_DIR/scripts/$os/$script.sh --source-only
}

make_exist() {
    local script=$1
    load_script $os $script
    install
}

packages=()
os="unknown"
set_os

# Iterate over required packages
for package in "${packages[@]}"; do
  make_exist $package
done
