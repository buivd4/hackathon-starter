# User Guide: Helm Chart Installation Script

## Overview

This script automates the installation of the NGINX Ingress Controller and a specified application using Helm. It checks if the NGINX Ingress Controller and the application are already installed, and installs or upgrades them as necessary.

## Prerequisites

- Helm must be installed and configured on your machine.
- Kubernetes cluster must be running and accessible.
- The script must be run with Bash (version 4 or later).

## Usage

1. Save the script to a file (e.g., `install_nginx_ingress.sh`).
2. Make the script executable by running `chmod +x install_nginx_ingress.sh`.
3. Run the script:
   ```bash
   ./install_nginx_ingress.sh
   ```

## How it Works

1. Check NGINX Ingress Installation: The script checks if the NGINX Ingress Controller is already installed using the check_nginx_ingress_installed function.
2. Install NGINX Ingress: If the NGINX Ingress Controller is not found, it adds the NGINX Helm repository, updates it, and installs the NGINX Ingress Controller.
3. Check Application Installation: The script checks if the specified application (default: hackathon-starter) is installed using the check_app_installed function.
4. Install or Upgrade Application: If the application is not found, it installs the application. If it is found, it upgrades the existing installation.

## Functions

- check_nginx_ingress_installed: Checks if the NGINX Ingress Controller is installed.
- check_app_installed: Checks if the specified application is installed.

## Troubleshooting

- If Helm is not installed or configured correctly, the script will fail to execute.
- If the Kubernetes cluster is not accessible, the script will not be able to install or upgrade the applications.
Ensure that the charts directory contains the Helm chart for the application.

## Customization

To change the application name, modify the APP_NAME variable at the beginning of the script.
You can also customize the Helm chart installation parameters as needed.
