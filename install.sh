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

# Check if installation was successful
if [ $? -eq 0 ]; then
	    echo "Packages nmap, cmatrix, and dnsutils installed successfully."
    else
	        echo "Error: Failed to install packages."
		    exit 1
fi

# Switch to non root user for remainder of commands
sudo -u jailend_ubuntu /bin/bash -c '
# Now we are running commands as the non-root user
echo "Running commands as the non-root user (jailend_ubuntu)"
echo "I am now user $(whoami)"

# Check for anaconda3
anaconda_dir="$HOME/anaconda3"

if [ -d "$anaconda_dir" ]; then
	    echo "Anaconda 3 is already installed in the default location: $anaconda_dir"
    else
	    echo "Anaconda 3 needs to be installed."
fi

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

# Link to ~/.ssh/authorized_keys and ~/.ssh/config
ln -sf ~/dotfiles/.ssh/authorized_keys ~/.ssh/authorized_keys
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config

# Vim customization

# Check if Vundle is installed
if [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
	    echo "Vundle is already installed."
    else
	    echo "Installing Vundle..."
	    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	    echo "Vundle installed successfully in default location."
fi
# Color Scheme check
if ! grep -q "colorscheme desert" ~/.vimrc; then
	echo "Changing colorscheme to desert..."
	echo "colorscheme desert" >> ~/.vimrc
	echo "Colorscheme changed successfully."
else
	echo "Colorscheme is already set to desert."
fi
# Add plugin configuration
'
