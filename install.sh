#!/bin/bash

# Check if the script is being run as root
if [ "$(id -u)" -eq 0 ]; then
	    echo "Running as root" 
else
	echo "Script is not being run as root"
	exit 1
fi

# Check if the APT binary exists in the PATH
if command -v apt >/dev/null 2>&1; then
	    echo "APT package manager is installed."
    else
	        echo "APT package manager is not installed."
		exit 1
fi

apt update
apt install -y cmatrix nmap dnsutils
# Check if installation was successful

if [ $? -eq 0 ]; then
	    echo "Packages cmatrix, nmap, and bind-tools installed successfully."
    else
	        echo "Error: Failed to install packages."
		    exit 1
fi
