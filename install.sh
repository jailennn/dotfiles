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

# Install packages
apt update
apt install -y dnsutils nmap cmatrix
apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

# Check if installation was successful
if [ $? -eq 0 ]; then
	    echo "Packages nmap, cmatrix, and dnsutils installed successfully."
    else
	        echo "Error: Failed to install packages."
		    exit 1
fi

# Switch to non root user for remainder of commands
sudo -u jailend_ubuntu /bin/bash <<EOF
# Now we are running commands as the non-root user
echo "Running commands as the non-root user (jailend_ubuntu)"

# Link to the .gitconfig and .bashrc file
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.bashrc ~/.bashrc

# ~/.ssh check
if [ -d ~/.ssh ]; then
    echo "~/.ssh folder already exists."
else
    echo "Creating ~/.ssh folder..."
    mkdir ~/.ssh
    echo "Created ~/.ssh folder."
fi

# Link to ~/.ssh/authorized_keys
ln -sf ~/dotfiles/authorized_keys ~/.ssh/authorized_keys

EOF
