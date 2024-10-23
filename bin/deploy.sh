#!/bin/bash
# Author: buivd4
APP_NAME="hackathon-starter"

check_nginx_ingress_installed() {
    # Check if the NGINX Ingress Controller is installed
    if helm ls -A | grep -qi ingress; then
        return 1
    else
        return 0
    fi
}
check_app_installed() {
    # Check if the NGINX Ingress Controller is installed
    if helm ls -A | grep -qi $APP_NAME ; then
        return 1
    else
        return 0
    fi
}

check_nginx_ingress_installed
if [ $? == 0 ]; then
    echo [INFO] Nginx Ingress not found, install Nginx Ingress ...
    helm repo add nginx-stable https://helm.nginx.com/stable
    helm repo update
    helm install nginx-ingress nginx-stable/nginx-ingress --set rbac.create=true
else
    echo [INFO] Nginx Ingress is already installed
fi

check_app_installed
if [ $? == 0 ]; then
    echo [INFO] Install $APP_NAME
    helm install $APP_NAME charts/$APP_NAME
else
    echo [INFO] Upgrade $APP_NAME
    helm upgrade $APP_NAME charts/$APP_NAME
fi