#!/bin/bash  


print_msg() {  
    local color="$1"  
    local msg="$2"  
    echo -e "${color}[+] ${msg}\033[0m"  
}  


GREEN="\033[0;32m"  
YELLOW="\033[0;33m"  
RED="\033[0;31m"  


print_msg "$YELLOW" "Installing essential tools..."  


install_packages=( \
    build-essential \     
    libssl-dev \         
    libnl-3-dev \        
    libnl-route-3-dev \  
    libpcap-dev \         
    libdumbnet-dev \     
    mdk3 \              
    mdk4 \              
    aircrack-ng \       
    dnsutils \         
    nmap \               
    git \                 
    amass \              
    figlet \             
    hping3 \ 
    toilet-fonts \
    dsniff              
)  


for package in "${install_packages[@]}"; do  
    if ! dpkg -l | grep -q "$package"; then  
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



