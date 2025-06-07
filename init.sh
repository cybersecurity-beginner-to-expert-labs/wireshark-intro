#!/bin/bash

# Function to install Prereqs if not already installed
function install_prereqs() {
    if ! command -v awk &> /dev/null
    then
        echo "Awk not found, installing..."
        sudo apt-get update
        sudo apt-get install -y gawk
    else
        echo "AWK is already installed."
    fi

    if ! command -v docker &> /dev/null
    then
        echo "Docker not found, installing..."
        sudo apt-get update
        sudo apt-get install -y docker.io docker-compose
    else
        echo "Docker is already installed."
    fi
}

# Function to clean up (stop and remove all containers except for Nginx)
function cleanup_containers() {
    echo "Stopping and removing all Docker containers..."
    sudo docker stop $(sudo docker ps -aq) 2>/dev/null
    sleep 1
    sudo docker rm -f $(sudo docker ps -aq) 2>/dev/null
}

# Function to pull and run Nginx Docker container
function run_nginx_container() {
    echo "Pulling Nginx Docker image..."
    sudo docker pull nginx
    echo "Running Nginx container in detached mode..."
    sudo docker run -d --name nginx-container nginx
}

# Main script logic
install_prereqs
cleanup_containers
run_nginx_container
echo "wireshark-intro lab ready to use ....."