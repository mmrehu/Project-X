#!/bin/bash  

# Function to print messages in color  
print_msg() {  
    local color="$1"  
    local msg="$2"  
    echo -e "${color}[+] ${msg}\033[0m"  
}  

# Define colors  
GREEN="\033[0;32m"  
YELLOW="\033[0;33m"  
RED="\033[0;31m"  

print_msg "$YELLOW" "Installing essential tools..."  

# List of essential tools and dependencies  
install_packages=(  
    # System utilities  
    build-essential  
    software-properties-common  
    curl  
    wget  
    git  
    unzip  
    zip  
    htop  
    tmux  
    screen  
    neofetch  

    # Networking tools  
    nmap  
    net-tools  
    dnsutils  
    iputils-ping  
    traceroute  
    whois  
    socat  
    hping3  
    aircrack-ng  
    amass  
    dsniff  
    tcpdump  
    wireshark  

    # Wireless tools  
    mdk3  
    mdk4  

    # Cryptography and security libraries  
    libssl-dev  
    libpcap-dev  
    libnl-3-dev  
    libnl-route-3-dev  
    libdumbnet-dev  

    # Ethical hacking tools  
    hydra  
    medusa  
    sqlmap  
    nikto  
    wfuzz  
    gobuster  
    wapiti  
    smtp-user-enum  
    enum4linux  
    john  
    hashcat  

    # Programming and scripting dependencies  
    python3  
    python3-pip  
    python3-venv  
    python3-dev  
    python3-setuptools  

    # Extra fonts and CLI aesthetics  
    figlet  
    toilet  
    toilet-fonts  
    cowsay  
    lolcat  
    sl  
    fortune  
    boxes  
)  

# Install each package  
for package in "${install_packages[@]}"; do  
    if ! dpkg -l | grep -q "^ii  $package "; then  
        print_msg "$YELLOW" "Installing $package..."  
        if sudo apt install -y "$package"; then  
            print_msg "$GREEN" "$package installed successfully."  
        else  
            print_msg "$RED" "Failed to install $package."  
        fi  
    else  
        print_msg "$GREEN" "$package is already installed."  
    fi  
done  

print_msg "$GREEN" "All essential tools have been installed successfully!"  
