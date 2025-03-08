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
print_msg "$YELLOW" "Removing selected tools..."  

# List of packages to be removed  
packages=(  
    mdk5   # Wireless attack tool  
    hping3 # Network tool for custom TCP/IP packet crafting  
)  

# Remove each package  
for package in "${packages[@]}"; do  
    if dpkg -l | grep -q "^ii  $package "; then  
        print_msg "$YELLOW" "Removing $package..."  
        if sudo apt remove -y "$package"; then  
            print_msg "$GREEN" "$package removed successfully."  
        else  
            print_msg "$RED" "Failed to remove $package."  
        fi  
    else  
        print_msg "$GREEN" "$package is not installed or already removed."  
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
print_msg "$GREEN" "Selected tools have been removed successfully!"  
