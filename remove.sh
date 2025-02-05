#!/bin/bash  

# Function to print messages in color  
print_msg() {  
    local color="$1"  
    local msg="$2"  
    echo -e "${color}[+] ${msg}\033[0m"  # Reset color after the message  
}  

# Define colors  
GREEN="\033[0;32m"  
YELLOW="\033[0;33m"  
RED="\033[0;31m"  

# Print a message to indicate the removal process is starting  
print_msg "$YELLOW" "Removing tools..."  

# List of packages to be removed  
packages=( \
    build-essential \     # General build tools  
    libssl-dev \         # Required for aircrack-ng  
    libnl-3-dev \        # Required for aircrack-ng  
    libnl-route-3-dev \  # Required for aircrack-ng  
    libpcap-dev \        # Required for networking tools like aircrack-ng   
    libdumbnet-dev \     # Required for dsniff and other network monitoring tools  
    mdk3 \               # Wireless attack tool  
    mdk4 \               # Modern version of mdk3  
    aircrack-ng \        # Wireless security tools  
    dnsutils \           # Provides nslookup  
    nmap \               # Network exploration tool  
    git \                # Version control system  
    amass \              # Tool for DNS enumeration and information gathering  
    figlet \             # Creates large text banners  
    hping3 \             # Network tool for custom TCP/IP packet crafting  
    dsniff               # Contains arpspoof and other network sniffing tools  
)  

# Remove each package  
for package in "${packages[@]}"; do  
    print_msg "$YELLOW" "Removing $package..."  
    if sudo apt remove -y "$package"; then  
        print_msg "$GREEN" "$package removed successfully."  
    else  
        print_msg "$RED" "Failed to remove $package."  
    fi  
done  

# Optionally, clean up residual configurations  
print_msg "$YELLOW" "Cleaning up unused packages..."  
if sudo apt autoremove -y; then  
    print_msg "$GREEN" "Unused packages cleaned up successfully."  
else  
    print_msg "$RED" "Failed to clean up unused packages."  
fi  

# Final success message  
print_msg "$GREEN" "All specified tools have been removed successfully!"
