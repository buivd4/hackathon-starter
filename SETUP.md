# User Guide: Automated Package Installer Script

## Overview

This script is designed to automate the installation of required packages on different operating systems. It currently supports macOS, Debian Linux, and RHEL Linux.

## Prerequisites

- The script must be run with Bash (version 4 or later).
- The script assumes that the required package managers (e.g., Homebrew on macOS, apt on Debian Linux, yum on RHEL Linux) are already installed and configured.

## Usage

1. Make the script executable by running `chmod +x bin/setup.sh`.
2. Run the script by executing `./bin/setup.sh`.

## How it Works

1. The script determines the operating system using the `OSTYPE` environment variable.
2. Based on the operating system, the script sets the `packages` array to the required packages for that OS.
3. The script then iterates over the `packages` array and calls the `make_exist` function for each package.
4. The `make_exist` function loads the corresponding installation script for the package and operating system, and then calls the `install` function to perform the installation.

## Supported Packages

The script currently supports the following packages:

- **macOS:**
  - xcode
  - nodejs
  - docker
  - minikube
- **Debian Linux:**
  - build-essential
  - nodejs
  - docker
  - minikube
- **RHEL Linux:**
  - build-essential
  - nodejs
  - docker
  - minikube

## Troubleshooting

- If the script fails to determine the operating system, it will exit with an error message.
- If a package installation fails, the script will print an error message and continue with the next package.

## Customization

To add support for additional packages or operating systems, you can modify the `packages` arrays and the `set_os` function accordingly. You will also need to create the corresponding installation scripts in the `scripts` directory.
