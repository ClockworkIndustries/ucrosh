#!/bin/bash
# U-Crosh
# Updated ChromeOS Shell
trap '' 2


#FOR DEVELOPMENT USES ONLY
ucroshlocation="/home/chronos/user/Downloads/ucrosh/crosh.sh"
mrchromeboxlocation="/usr/bin/ucrosh/firmware-util.sh"

if [ "$EUID" -eq 1000 ]; then # root esc for vpd log
  clear
  sudo bash $ucroshlocation
  exit
fi

clear #Removes the dumb noexec thing when in testing

sudo rm -rf /tmp/vpd.log #required for pollen check & intercepting chrome binary
sudo dump_vpd_log --stdout >> /tmp/vpd.log





# ========|| Functions ||=======
#Thank you MW for this function :)
swallow_stdin() {
    while read -t 0 notused; do
        read input
    done
}





#Thank you MW for this function aswell :)
runjob() {
    trap 'kill -2 $! >/dev/null 2>&1' INT
    trap 2
    (
        $@
    )
    trap '' INT
}


# =======|| Commands ||=======

pollencheck() {
  if cat /tmp/vpd.log | grep -q '"check_enrollment"="0"'; then
    echo "erm i think pollen is useless unenrolled"
    read -r
else
    echo "erm no more pollen :SHOCK:"
    read -r
fi
}

lilacflagsintercept() {
  if cat /tmp/vpd.log | grep -q '"check_enrollment"="0"'; then
    echo "erm i think lilac is useless unenrolled"
    read -r
else
    echo "erm no more lilac :SHOCK:"
    read -r
fi
}

mrchromebox() {
  clear
  cd ucrosh
  curl -LOk mrchromebox.tech/firmware-util.sh && sudo -u chronos sudo bash firmware-util.sh
}

credits() {
  clear
  cat <<-EOF
  kxtzownsu - Making U-Crosh
  Mercury Workshop - Inspiration, making mush which is what made me make this, and some of the stuff in the source code
  Stack Overflow - Helping me not lose my sanity
  
  Press [ENTER] to go back
EOF
  read -r
}







#U-Crosh Menu
while true; do
  clear
  cat <<-EOF
Welcome to U-Crosh! The Updated ChromeOS Shell, a program made by Clockwork Industries

NOTE: The sudo command at the beginning was for RW_VPD, its for lilac and pollen.

EOF
  cat <<-EOF
1) Chronos Shell
2) Root Shell
3) Crosh
4) Install Pollen
5) Edit Chrome Binary Intercepting Flags (for lilac)
6) MrChromebox (Requires WiFi)
7) Credits
8) Exit
EOF
  read -r -p "> (1-8): " choice
  case "$choice" in
  1) runjob sudo -u chronos bash ;;
  2) runjob bash ;;
  3) runjob sudo /usr/bin/crosh.old ;;
  4) runjob pollencheck ;;
  5) runjob lilacflagsintercept ;;
  6) runjob mrchromebox ;;
  7) runjob credits ;;
  8) exit ;;
  *) echo "invalid option" ;;
  esac
done
