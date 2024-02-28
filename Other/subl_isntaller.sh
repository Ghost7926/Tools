#!/bin/bash
if [[ $EUID -ne 0 ]]; then
  echo "This must be run with root priviledges..."
  sleep 1
  echo "Try Harder"
  exit 1
fi 

cat << "EOF"

 ██████   ██████   ██████  ██████                                                  
██       ██    ██ ██    ██ ██   ██                                                 
██   ███ ██    ██ ██    ██ ██   ██                                                 
██    ██ ██    ██ ██    ██ ██   ██                                                 
 ██████   ██████   ██████  ██████                                                  
                                                                                   
                                                                                   
 █████  ███████ ████████ ███████ ██████  ███    ██  ██████   ██████  ███    ██     
██   ██ ██         ██    ██      ██   ██ ████   ██ ██    ██ ██    ██ ████   ██     
███████ █████      ██    █████   ██████  ██ ██  ██ ██    ██ ██    ██ ██ ██  ██     
██   ██ ██         ██    ██      ██   ██ ██  ██ ██ ██    ██ ██    ██ ██  ██ ██     
██   ██ ██         ██    ███████ ██   ██ ██   ████  ██████   ██████  ██   ████     
                                                                                   
                                                                                   
███████ ██ ██████                                                                  
██      ██ ██   ██                                                                 
███████ ██ ██████                                                                  
     ██ ██ ██   ██                                                                 
███████ ██ ██   ██                                                                 
                                                                                   
                                                                                                                              
EOF

echo "Installing Sublime..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
apt-get update
apt-get install sublime-text
echo "Download complete."
