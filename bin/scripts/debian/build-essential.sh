#!/bin/bash

pre_install() {
  if dpkg -l | grep -q "build-essential"; then
    echo "[INFO] build-essential is already installed. Skipping ..."
    return 1
  else
    return 0
  fi
}

post_install() {
  if dpkg -l | grep -q "build-essential"; then
    echo "[INFO] Installed build-essential successfully"
    return 0
  else
    echo "[ERROR] Installation of build-essential was not successful"
    exit 1
  fi
}

install() {
  echo "[INFO] Attempting to install build-essential ..."
  pre_install
  if [ $? -eq 0 ]; then
    sudo apt update
    sudo apt install -y build-essential
    post_install
    return 0
  fi
}

# Call the install function to start the process
install