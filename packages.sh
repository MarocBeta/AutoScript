#!/bin/bash

rm -rf /root/packages.sh >/dev/null 2>&1

clear
MYIP=$(curl -sS ipv4.icanhazip.com)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')

date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/MarocBeta/Permission/main/access"

clear
checking_sc() {
useexp=$(wget -qO- $data_ip | grep $MYIP | awk '{print $3}')
if [[ $date_list < $useexp ]]; then
echo -ne
else
echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          \033[0m"
echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
echo -e ""
echo -e "            \033[91;1mPERMISSION DENIED !\033[0m"
echo -e "   \033[0;33mYour VPS\033[0m $MYIP \033[0;33mHas been Banned\033[0m"
echo -e "     \033[0;33mBuy access permissions for scripts\033[0m"
echo -e "             \033[0;33mContact Admin :\033[0m"
echo -e "      \033[2;32mWhatsApp:\033[0m wa.me/212608607325"
echo -e "      \033[2;32mTelegram:\033[0m t.me/MarocBeta"
echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
exit 0
fi
}

checking_sc

sudo apt install -y git
sudo apt install -y curl
sudo apt install -y ruby
sudo apt install -y figlet
sudo apt install -y lolcat
sudo gem install lolcat

packages=(
  
  cmake jq at zip unzip p7zip-full
  
  netfilter-persistent xz-utils fail2ban
  
  openssl lsof libssl-dev net-tools gnupg1
  
  python python3-pip certbot dos2unix htop
)

for package in "${packages[@]}"; do
  sudo apt-get install -y "$package"
done

sudo apt-get autoclean -y
sudo apt-get autoremove -y
sudo apt-get autoremove ufw -y >/dev/null 2>&1
sudo apt-get autoremove firewalld -y >/dev/null 2>&1
sudo apt-get autoremove apache2 -y >/dev/null 2>&1

if [ -f /var/lib/dpkg/statoverride ]; then
    sed -i '/Debian-exim/d' /var/lib/dpkg/statoverride
fi