#!/bin/bash
#U-Crosh Installer

echo "IF YOU PRESS ENTER, IT WILL INSTALL U-CROSH WITHOUT ANY MORE WARNINGS!!!! PRESS CTRL+C TO CANCEL!!   NOTE: THIS NEEDS SUDO ACCESS"
read -r
sudo mv /usr/bin/crosh /usr/bin/crosh.old
cd /usr/
sudo curl -LOk raw.githubusercontent.com/ClockworkIndustries/ucrosh/main/crosh.sh
sudo cp /usr/crosh.sh /usr/bin/crosh
sudo mkdir /usr/bin/ucrosh/
sudo chmod +x /usr/bin/crosh
sudo chmod +x /usr/bin/crosh.old
echo "DONE!"
