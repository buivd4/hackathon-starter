#!/bin/bash

pre_install() {
  if yum list installed Development\ Tools &> /dev/null; then
    echo "[INFO] Development Tools are already installed. Skipping ..."
    return 1
  else
    return 0
  fi
}

post_install() {
  if yum list installed Development\ Tools &> /dev/null; then
    echo "[INFO] Installed Development Tools successfully"
    return 0
  else
    echo "[ERROR] Installation of Development Tools was not successful"
    exit 1
  fi
}

install() {
  echo "[INFO] Attempting to install Development Tools ..."
  pre_install
  if [ $? -eq 0 ]; then
    sudo yum groupinstall -y "Development Tools"
    post_install
    return 0
  fi
}

# Call the install function to start the process
install