#!/bin/bash
if [[ $EUID -ne 0 ]]; then
  echo "This must be run with root priviledges..."
  sleep 1
  echo "Try Harder"
  exit 1
fi 

cat << "EOF"
██     ██ ███████ ██      ██████  ██████  ███    ███ ███████ 
██     ██ ██      ██     ██      ██    ██ ████  ████ ██      
██  █  ██ █████   ██     ██      ██    ██ ██ ████ ██ █████   
██ ███ ██ ██      ██     ██      ██    ██ ██  ██  ██ ██      
 ███ ███  ███████ ███████ ██████  ██████  ██      ██ ███████ 
                                                             
  ▄████  ██░ ██  ▒█████    ██████ ▄▄▄█████▓
 ██▒ ▀█▒▓██░ ██▒▒██▒  ██▒▒██    ▒ ▓  ██▒ ▓▒
▒██░▄▄▄░▒██▀▀██░▒██░  ██▒░ ▓██▄   ▒ ▓██░ ▒░
░▓█  ██▓░▓█ ░██ ▒██   ██░  ▒   ██▒░ ▓██▓ ░ 
░▒▓███▀▒░▓█▒░██▓░ ████▓▒░▒██████▒▒  ▒██▒ ░ 
 ░▒   ▒  ▒ ░░▒░▒░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░  ▒ ░░   
  ░   ░  ▒ ░▒░ ░  ░ ▒ ▒░ ░ ░▒  ░ ░    ░    
░ ░   ░  ░  ░░ ░░ ░ ░ ▒  ░  ░  ░    ░      
      ░  ░  ░  ░    ░ ░        ░           
                                           
EOF

###################
# Update packages #
###################

# apt update
echo "Updating package repos..."
apt update > /dev/null 2>&1
echo "Succcess"

####################################
# Installing the apt install Tools #
####################################

applications=("seclists" "bloodhound" "gobuster" "gedit" "eyewitness" "golang-go" "htop" "sshuttle") 

for app in "${applications[@]}"; do
  echo "Installing $app..."
  apt install -y "$app" > /dev/null 2>&1
  echo "Installation of $app complete."
done

###########################
# Downloads from internet #
###########################

# Downloading Impackets
echo "Downloading impacket..."
for file in $(cat impacket/impacketvLatest.txt); do 
  wget -P impacket ${file} > /dev/null 2>&1; 
done
echo "Download complete."
echo "Unzipping downloaded folder..."
tar -xf impacket/impacket-*.tar.gz -C impacket-latest > /dev/null 2>&1
echo "Unzip complete. Further action will be required for the latest impacket."

# Downloading Impackets 9.19
echo "Unzipping impacket 9.19..."
tar -xf impacket/impacket-0.9.19.tar.gz -C impacket-9.19 > /dev/null 2>&1
echo "Unzip complete. Further action will be required for impacket 9.19."

# Downloading Certipy from github
echo "Downloading Certipy..."
for file in $(cat ActiveDirectory/URLinks/Certipy.txt); do 
  git clone ${file} ActiveDirectory/Certipy > /dev/null 2>&1; 
done
echo "Download complete. Further action will be required to install Certipy."

# Download LdapRelayScan from github
echo "Downloading LdapRelayScan..."
for file in $(cat ActiveDirectory/URLinks/LdapRelayScan.txt); do 
  git clone ${file} ActiveDirectory/LdapRelayScan > /dev/null 2>&1; 
done
echo "Download complete."

# Downloading Sublist3r
echo "Unzipping Sublist3r..."
tar -xf web/Sublist3r-1.1.tar.gz -C Sublist3r > /dev/null 2>&1
echo "Unzip complete."

# Unzipping ligolo-ng
echo "Unzipping ligolo-ng..."
tar -xf Pivoting/ligolo-ng-0.5.1.tar.gz -C ligolo-ng-0.5.1 > /dev/null 2>&1
echo "Unzip complete."

# Chmod Kerbrute
chmod 777 ActiveDirectory/Kerbrute

###############
# Rockyou.txt #
###############

if [ -f "/usr/share/wordlists/rockyou.txt.gz" ]; then
  gunzip "/usr/share/wordlists/rockyou.txt.gz"
  echo "rockyou.txt extracted successfully."
else
    echo "rockyou.txt is already unzipped. Good job."
fi

echo ""
echo "Installation of tools complete. Happy Hacking!"
