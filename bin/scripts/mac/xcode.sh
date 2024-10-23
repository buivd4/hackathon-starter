#!/bin/bash

pre_install() {
  if [ -d "/Applications/Xcode.app" ]; then
    echo "[INFO] XCode are already installed. Skipping ..."
    return -1
  else
    return 0
  fi
}

post_install() {
    if [ -d "/Applications/Xcode.app" ]; then
      echo "[INFO] Install XCode successfully"
      return 0
    else
      echo "[ERROR] Install XCode not successfully"
      exit -1
    fi
}
install() {
    echo "[INFO] Attempting to install XCode ..."
    pre_install
    if [ $? -eq 0 ]; then
      xcode-select --install
      post_install
      return 0
    fi
}

