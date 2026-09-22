#!/bin/bash

rm -rf /root/setup.sh >/dev/null 2>&1

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
echo -e "      \033[2;32mWhatsApp:\033[0m wa.me/6285225416745"
echo -e "      \033[2;32mTelegram:\033[0m t.me/RidwanzSaputra"
echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
exit 0
fi
}

checking_sc

Green="\e[92;1m"
green='\e[0;32m'
RED="\033[1;31m"
BLUE="\033[36m"
GRAY="\e[1;30m"
YELLOW="\033[33m"
REDBG="\033[41;37m"
FONT="\033[0m"
NC='\e[0m'
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"

REPO1="https://raw.githubusercontent.com/MarocBeta/AutoScript/main/"
REPO2="https://raw.githubusercontent.com/KbmnGlntr/Files/main/"
REPO3="https://raw.githubusercontent.com/KbmnGlntr/Config/main/"

start=$(date +%s)

log_date_install() {

echo "Installation Time: $((${1} / 3600)) hours $(((${1} / 60) % 60)) minutes $((${1} % 60)) seconds."
}

clear
if [[ $( uname -m | awk '{print $1}' ) == "x86_64" ]]; then
echo -e "${OK} Your Architecture Is Supported ( ${green}$( uname -m )${NC} )"

else
echo -e "${EROR} Your Architecture Is Not Supported ( ${YELLOW}$( uname -m )${NC} )"
exit 1
fi

os_id=$(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g')

os_name=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
if [[ "$os_id" == "ubuntu" ]]; then

clear
echo -e "${OK} Your OS Is Supported ( ${green}$os_name${NC} )"
elif [[ "$os_id" == "debian" ]]; then

clear
echo -e "${OK} Your OS Is Supported ( ${green}$os_name${NC} )"
else

echo -e "${EROR} Your OS Is Not Supported ( ${YELLOW}$os_name${NC} )"
exit 1
fi

if [[ $MYIP == "" ]]; then
echo -e "${EROR} IP Address ( ${RED}Not Detected!${NC} )"

else
echo -e "${OK} IP Address ( ${green}$MYIP${NC} )"
fi

echo ""
read -p "$( echo -e "Press ${GRAY}[ ${NC}${green}Enter${NC} ${GRAY}]${NC} For Starting Installation.") "
echo ""

function print_ok() {
echo -e "${OK} ${BLUE} $1 ${FONT}"
}

function print_error() {
echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}

function print_install() {
echo -e "${green}•====================================================•${FONT}"
echo -e "${YELLOW} # $1 ${FONT}"
echo -e "${green}•====================================================•${FONT}"
sleep 2
}

function print_success() {
if [[ 0 -eq $? ]]; then

echo -e "${green}•=================================================•${FONT}"
echo -e "${Green} # $1"
echo -e "${green}•=================================================•${FONT}"
sleep 3
fi
}

clear
if [[ "$UID" -eq 0 ]]; then
print_ok "Root User. Start Installation Process!"
else

clear
echo ""
print_error "The current user is not the root user. Please switch to the root user and run the script again."
exit 0
fi

sleep 3
function directory_xray() {
clear
print_install "Create Directory Xray"
mkdir -p /etc/xray
mkdir -p /var/log/xray
mkdir -p /usr/local/share/xray
chmod +x /var/log/xray
touch /var/log/xray/error.log
touch /var/log/xray/access.log
sudo chown -R www-data:www-data /var/log/xray
clear
print_success "Directory Xray Created Successfully"
}

function directory_config() {
clear
print_install "Create Directory Configurations"
mkdir -p /etc/bot
mkdir -p /etc/ssh
mkdir -p /etc/vless
mkdir -p /etc/vmess
mkdir -p /etc/trojan
mkdir -p /etc/rs/limit/ssh/ip
mkdir -p /etc/rs/limit/vmess/ip
mkdir -p /etc/rs/limit/vless/ip
mkdir -p /etc/rs/limit/trojan/ip
mkdir -p /etc/limit/ssh
mkdir -p /etc/limit/vmess
mkdir -p /etc/limit/vless
mkdir -p /etc/limit/trojan
touch /etc/bot/.bot.db
touch /etc/ssh/.ssh.db
touch /etc/vmess/.vmess.db
touch /etc/vless/.vless.db
touch /etc/trojan/.trojan.db
clear
print_success "Directory Configurations Created Successfully"
}

function settings_debconf() {
clear
print_install "Settings Debconf Configurations"
export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string"
debconf-set-selections <<<"console-setup console-setup/charmap47 select UTF-8"
debconf-set-selections <<<"console-setup console-setup/codeset47 select Guess optimal character set"
debconf-set-selections <<<"dropbear dropbear/enable_syslog boolean true"
debconf-set-selections <<<"cryptsetup cryptsetup/confirm boolean true"
debconf-set-selections <<<"cryptsetup cryptsetup/compat boolean true"

echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
clear
print_success "Debconf Configurations Settings Successfully"
}

function setup_nginx() {
clear
OS_ID=$(grep -w ID /etc/os-release | cut -d'=' -f2 | tr -d '"')
OS_NAME=$(grep -w PRETTY_NAME /etc/os-release | cut -d'=' -f2 | tr -d '"')
if [[ "$OS_ID" == "ubuntu" ]]; then

print_install "Setup Nginx For $OS_NAME"
sudo apt update
rm -rf /etc/apt/sources.list.d/nginx.list
if ! dpkg -s software-properties-common >/dev/null 2>&1; then
apt-get install --no-install-recommends software-properties-common
fi

if ! dpkg -s ubuntu-keyring >/dev/null 2>&1; then
apt install -y ubuntu-keyring
fi

curl -fsSL https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null 2>&1

echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" | tee /etc/apt/sources.list.d/nginx.list

echo "Package: *
Pin: origin nginx.org
Pin: release o=nginx
Pin-Priority: 900" | tee /etc/apt/preferences.d/99nginx

sudo apt update
sudo apt install nginx -y
rm -rf /etc/nginx/conf.d/default.conf

clear
print_success "Nginx For OS $OS_NAME"
elif [[ "$OS_ID" == "debian" ]]; then

print_install "Setup Nginx For $OS_NAME"
sudo apt update -y
rm -rf /etc/apt/sources.list.d/nginx.list
if ! dpkg -s debian-archive-keyring >/dev/null 2>&1; then
apt install -y debian-archive-keyring
fi

curl -fsSL https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null 2>&1

echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/debian $(lsb_release -cs) nginx" | tee /etc/apt/sources.list.d/nginx.list

echo "Package: *
Pin: origin nginx.org
Pin: release o=nginx
Pin-Priority: 900" | tee /etc/apt/preferences.d/99nginx

sudo apt update
sudo apt-get install -y nginx 
rm -rf /etc/nginx/conf.d/default.conf

clear
print_success "Nginx For OS $OS_NAME"
else
echo -e "Your OS ($OS_NAME) is not supported."
exit 0
fi
}

function setup_haproxy() {
clear
OS_ID=$(grep -w ID /etc/os-release | cut -d'=' -f2 | tr -d '"')
OS_NAME=$(grep -w PRETTY_NAME /etc/os-release | cut -d'=' -f2 | tr -d '"')
if [[ "$OS_ID" == "ubuntu" ]]; then

print_install "Setup Haproxy For $OS_NAME"
sudo apt update
sudo apt install haproxy -y
rm -rf /usr/sbin/haproxy
wget -q -O /usr/sbin/haproxy "${REPO2}haproxy"
chmod +x /usr/sbin/haproxy

LIBLUA_DEB="liblua5.3-0_5.3.3-1.1ubuntu2_amd64.deb"
LIBLUA_URL="http://archive.ubuntu.com/ubuntu/pool/main/l/lua5.3/$LIBLUA_DEB"

if ! dpkg -s liblua5.3-0 &>/dev/null; then
[ ! -f "$LIBLUA_DEB" ] && wget -q "$LIBLUA_URL"
sudo dpkg -i "$LIBLUA_DEB"
rm -rf "$LIBLUA_DEB"
fi

LIBSSL_DEB="libssl1.1_1.1.1f-1ubuntu2_amd64.deb"
LIBSSL_URL="http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/$LIBSSL_DEB"

if ! dpkg -s libssl1.1 &>/dev/null; then
[ ! -f "$LIBSSL_DEB" ] && wget -q "$LIBSSL_URL"
sudo dpkg -i "$LIBSSL_DEB"
rm -rf "$LIBSSL_DEB"
fi

LIBPCRE_DEB="libpcre3_8.39-12ubuntu0.1_amd64.deb"
LIBPCRE_URL="http://archive.ubuntu.com/ubuntu/pool/main/p/pcre3/$LIBPCRE_DEB"

if ! dpkg -s libpcre3 &>/dev/null; then
[ ! -f "$LIBPCRE_DEB" ] && wget -q "$LIBPCRE_URL"
sudo dpkg -i "$LIBPCRE_DEB"
rm -rf "$LIBPCRE_DEB"
fi

sudo ldconfig

clear
print_success "Haproxy For OS $OS_NAME"
elif [[ "$OS_ID" == "debian" ]]; then

print_install "Setup Haproxy For $OS_NAME"
sudo apt update
sudo apt install haproxy -y
rm -rf /usr/sbin/haproxy
wget -q -O /usr/sbin/haproxy "${REPO2}haproxy"
chmod +x /usr/sbin/haproxy

LIBLUA_DEB="liblua5.3-0_5.3.6-1+deb11u1_amd64.deb"
LIBLUA_URL="http://archive.debian.org/debian/pool/main/l/lua5.3/$LIBLUA_DEB"

if ! dpkg -s liblua5.3-0 &>/dev/null; then
[ ! -f "$LIBLUA_DEB" ] && wget -q "$LIBLUA_URL"
sudo dpkg -i "$LIBLUA_DEB"
rm -rf "$LIBLUA_DEB"
fi

LIBSSL_DEB="libssl1.1_1.1.1n-0+deb10u6_amd64.deb"
LIBSSL_URL="http://archive.debian.org/debian-security/pool/updates/main/o/openssl/$LIBSSL_DEB"

if ! dpkg -s libssl1.1 &>/dev/null; then
[ ! -f "$LIBSSL_DEB" ] && wget -q "$LIBSSL_URL"
sudo dpkg -i "$LIBSSL_DEB"
rm -rf "$LIBSSL_DEB"
fi

LIBPCRE_DEB="libpcre3_8.39-12_amd64.deb"
LIBPCRE_URL="http://archive.debian.org/debian/pool/main/p/pcre3/$LIBPCRE_DEB"

if ! dpkg -s libpcre3 &>/dev/null; then
[ ! -f "$LIBPCRE_DEB" ] && wget -q "$LIBPCRE_URL"
sudo dpkg -i "$LIBPCRE_DEB"
rm -rf "$LIBPCRE_DEB"
fi

sudo ldconfig

clear
print_success "Haproxy For OS $OS_NAME"
else
echo -e "Your OS ($OS_NAME) is not supported."
exit 0
fi
}

function install_packages() {
clear
print_install "Installing The Required Packages"
wget ${REPO1}packages.sh
chmod +x packages.sh
./packages.sh
clear
print_success "The Required Packages Installed Successfully"
}

function install_domain() {
clear
echo ""
echo -e "------------------------------------"
echo -e "|\e[1;32mPlease Select a Domain Type Below \e[0m|"
echo -e "------------------------------------"
echo -e "\e[1;32m1)\e[0m Use Your Own Domain"
echo -e "\e[1;32m2)\e[0m Use Your Random Domain "
echo -e "------------------------------------"
read -p "Please select numbers 1-2 : " host
echo ""

if [[ $host == "1" ]]; then

clear
echo ""
echo -e "\e[1;36m_______________________________$NC"
echo -e "\e[1;32m SETTINGS DOMAINS $NC"
echo -e "\e[1;36m_______________________________$NC"
echo ""

read -p "Enter Your Subdomains: " host1
echo $host1 > /etc/xray/domain
echo $host1 > /root/domain
echo "Ridwanz Tunneling" > /etc/xray/username

elif [[ $host == "2" ]]; then

clear
echo ""
sleep 2
echo -e "\e[1;36m_______________________________$NC"
echo -e "\e[1;32m RANDOM SUBDOMAIN USED!$NC"
echo -e "\e[1;36m_______________________________$NC"
echo ""
echo "Ridwanz Tunneling" > /etc/xray/username

wget -q ${REPO1}Files/pointing && chmod +x pointing && ./pointing

clear
else
echo -e "\e[1;31mInvalid Selections! Using Random Subdomain...\e[0m"
clear
fi
}

clear
function notif_autoscript() {
DOMAIN=$(cat /etc/xray/domain)
OS=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
RAM=$(free -m | awk 'NR==2 {print $2}')
MYIP=$(curl -sS ipinfo.io/ip)
CITY=$(curl -s ipinfo.io/city)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)

USERNAME=$(curl -sS https://raw.githubusercontent.com/MarocBeta/Permission/main/access | grep $MYIP | awk '{print $2}')
DATE=$(curl -sS https://raw.githubusercontent.com/MarocBeta/Permission/main/access | grep $MYIP | awk '{print $3}')

d1=$(date -d "$DATE" +%s)
d2=$(date -d "$(date)" +%s)
EXPIRED=$(( ((d1 - d2) + 86399) / 86400 ))

CHATID="5692196612"
KEY="7534596469:AAG8Myur5wC6hCctbGraT0BnpmUtXozYdIY"
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TEXT="
<code>•─────────────────•</code>
<b>⚡INSTALLATION AUTOSCRIPT⚡</b>
<code>•─────────────────•</code>
<b>INFORMATION USER</b>
<code>•─────────────────•</code>
<code>USERNAME : $USERNAME</code>
<code>EXPIRED : ${EXPIRED} Days</code>
<code>DATE : $DATE</code>
<code>•─────────────────•</code>
<b>INFORMATION VPS</b>
<code>•─────────────────•</code>
<code>DOMAIN : $DOMAIN</code>
<code>IPVPS : $MYIP</code>
<code>OS : $OS</code>
<code>RAM : ${RAM} MB</code>
<code>CITY : $CITY</code>
<code>ISP : $ISP</code>
<code>•─────────────────•</code>
<b> Bot By: @RidwanzSaputra</b>
<code>•─────────────────•</code>
<i>Automatic Notifications From Github.</i>"

curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL > /dev/null 2>&1
}

function install_ssl_domain() {
clear
print_install "Installing SSL Certificate on the Domain"
domain=$(cat /root/domain)
systemctl stop nginx >/dev/null 2>&1
systemctl stop haproxy >/dev/null 2>&1
certbot --agree-tos certonly --register-unsafely-without-email --standalone -d $domain
cp /etc/letsencrypt/live/$domain/fullchain.pem /etc/xray/xray.crt
cp /etc/letsencrypt/live/$domain/privkey.pem /etc/xray/xray.key
chmod 777 /etc/xray/xray.key
clear
print_success "SSL Certificate Installed Successfully"
}

function install_xray() {
clear
print_install "Installing Xray Core"
wget -O /usr/local/bin/xray "${REPO2}xray"

chmod +x /usr/local/bin/xray >/dev/null 2>&1

wget -O /etc/systemd/system/xray.service "${REPO1}Service/xray.service" 
 
wget -O /etc/xray/config.json "${REPO3}config.json"

systemctl start xray.service >/dev/null 2>&1

systemctl enable xray.service >/dev/null 2>&1

clear
print_success "Xray Core Installed Successfully"
}

function xray_configurations() {
clear
print_install "Installing Xray Configurations"
curl -s ipinfo.io/city >>/etc/xray/city
curl -s ifconfig.me > /etc/xray/ipvps
curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp

wget -O /etc/haproxy/haproxy.cfg "${REPO3}haproxy.cfg"

wget -O /etc/nginx/conf.d/xray.conf "${REPO3}xray.conf"

domain=$(cat /etc/xray/domain)

sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf

curl ${REPO3}nginx.conf > /etc/nginx/nginx.conf

cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem

wget -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"

wget -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" 

clear
print_success "Xray Configurations Installed Successfully"
}

function settings_ssh_password(){
clear
print_install "Settings SSH Password"
wget -O /etc/pam.d/common-password "${REPO2}password"
chmod +x /etc/pam.d/common-password

timedatectl set-timezone Asia/Jakarta
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
clear
print_success "SSH Password Settings Successfully"
}

function setting_dns_resolver(){
clear
print_install "Settings DNS Resolver"
rm -rf /etc/resolv.conf >/dev/null 2>&1
cat > /etc/resolv.conf <<-EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF
sudo systemctl enable systemd-resolved
sudo systemctl start systemd-resolved
sudo systemctl restart systemd-resolved
clear
print_success "DNS Resolver Settings Successfully"
}

function instal_ram_monitor(){
clear
print_install "Installing  RAM Monitoring 80%"
wget -q ${REPO1}Files/monitor
chmod +x monitor
./monitor
clear
print_success "RAM Monitoring Installed Successfully"
}

function install_limit_ssh(){
clear
print_install "Installing Limit IP SSH Services"
wget -O /usr/local/bin/limit-ip-ssh "${REPO1}Limit/limit-ip-ssh"

chmod +x /usr/local/bin/limit-ip-ssh > /dev/null 2>&1

wget -q -O /etc/systemd/system/limitsship.service "${REPO1}Service/limitsship.service"

systemctl start limitsship.service
systemctl enable limitsship.service
systemctl restart limitsship.service

clear
print_success "Limit IP SSH Services Installed Successfully"
}

function install_limit_xray(){
clear
print_install "Installing  Limit IP & Quota Xray Services"
wget -O /usr/local/bin/limit-ip-xray "${REPO1}Limit/limit-ip-xray"
wget -O /usr/local/bin/limit-quota-xray "${REPO1}Limit/limit-quota-xray"

chmod +x /usr/local/bin/limit-ip-xray > /dev/null 2>&1
chmod +x /usr/local/bin/limit-quota-xray > /dev/null 2>&1

wget -q -O /etc/systemd/system/vmip.service "${REPO1}Service/vmip.service"
wget -q -O /etc/systemd/system/vlip.service "${REPO1}Service/vlip.service"
wget -q -O /etc/systemd/system/trip.service "${REPO1}Service/trip.service"

systemctl start vmip.service
systemctl start vlip.service
systemctl start trip.service

systemctl enable vmip.service
systemctl enable vlip.service
systemctl enable trip.service

systemctl restart vmip.service
systemctl restart vlip.service
systemctl restart trip.service

wget -q -O /etc/systemd/system/vmq.service "${REPO1}Service/vmq.service"
wget -q -O /etc/systemd/system/vlq.service "${REPO1}Service/vlq.service"
wget -q -O /etc/systemd/system/trq.service "${REPO1}Service/trq.service"

systemctl start vmq.service
systemctl start vlq.service
systemctl start trq.service

systemctl enable vmq.service
systemctl enable vlq.service
systemctl enable trq.service

systemctl restart vmq.service
systemctl restart vlq.service
systemctl restart trq.service

clear
print_success "Limit Quota & IP Xray Installed Successfully"
}

function install_badvpn(){
clear
print_install "Installing Badvpn UDPGW"
mkdir -p /usr/local/udpgw >/dev/null 2>&1
wget -q -O /usr/local/udpgw/badvpn "${REPO2}badvpn"
chmod +x /usr/local/udpgw/badvpn

wget -q -O /etc/systemd/system/badvpn1.service "${REPO1}Service/badvpn1.service"
wget -q -O /etc/systemd/system/badvpn2.service "${REPO1}Service/badvpn2.service"
wget -q -O /etc/systemd/system/badvpn3.service "${REPO1}Service/badvpn3.service"

systemctl daemon-reload

systemctl disable badvpn1.service
systemctl stop badvpn1.service
systemctl enable badvpn1.service
systemctl start badvpn1.service
systemctl restart badvpn1.service

systemctl disable badvpn2.service
systemctl stop badvpn2.service
systemctl enable badvpn2.service
systemctl start badvpn2.service
systemctl restart badvpn2.service

systemctl disable badvpn3.service
systemctl stop badvpn3.service
systemctl enable badvpn3.service
systemctl start badvpn3.service
systemctl restart badvpn3.service

clear
print_success "Badvpn UDPGW Installed Successfully"
}

function install_ws(){
clear
print_install "Installing WebSocket Proxy"
wget -O /usr/bin/ws "${REPO2}ws"
wget -O /usr/bin/config.yml "${REPO3}config.yml"
wget -O /etc/systemd/system/ws.service "${REPO1}Service/ws.service"

chmod +x /usr/bin/ws
chmod 644 /usr/bin/config.yml

systemctl disable ws.service
systemctl stop ws.service
systemctl enable ws.service
systemctl start ws.service

clear
print_success "WebSocket Proxy Installed Successfully"
}

function install_squid(){
clear
print_install "Installing Squid Proxy"
apt install squid -y
rm -rf /etc/squid/squid.conf >/dev/null 2>&1
wget -O /etc/squid/squid.conf "${REPO3}squid.conf"
sed -i "s/xxx/${MYIP}/g" /etc/squid/squid.conf
sed -i "s/rsvpns/${DOMAIN}/g" /etc/squid/squid.conf
clear
print_success "Squid Proxy Installed Successfully"
}

function install_ohp(){
clear
print_install "Installing OHP Server"
wget -q ${REPO1}Files/ohp
chmod +x ohp
./ohp
clear
print_success "OHP Server Installed Successfully"
}

function install_dropbear(){
clear
print_install "Installing Dropbear"
sudo apt-get install -y dropbear
dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key
wget -O /etc/default/dropbear "${REPO3}dropbear.conf"
chmod +x /etc/default/dropbear
rm -rf /usr/sbin/dropbear >/dev/null 2>&1
wget -O /usr/sbin/dropbear "${REPO2}dropbear"
chmod +x /usr/sbin/dropbear
clear
print_success "Dropbear Installed Successfully"
}

function install_sshd(){
clear
print_install "Installing SSHD"
wget -O /etc/ssh/sshd_config "${REPO2}sshd"
chmod 700 /etc/ssh/sshd_config >/dev/null 2>&1
clear
print_success "SSHD Installed Successfully"
}

function install_banner(){
clear
print_install "Installing Banner SSH"
wget -O /etc/issue.net "${REPO1}Banner/issue.net"
clear
print_success "Banner SSH Installed Successfully"
}

function install_openvpn(){
clear
print_install "Installing OpenVPN"
wget -q ${REPO1}Files/openvpn
chmod +x openvpn
./openvpn
clear
print_success "OpenVPN Installed Successfully"
}

function install_udp(){
clear
print_install "Installing UDP-Custom"
mkdir -p /usr/bin/udp >/dev/null 2>&1
wget -O /usr/bin/udp/udp-custom "${REPO2}udp"
wget -O /usr/bin/udp/config.json "${REPO3}udp.json"
wget -O /etc/systemd/system/udp-custom.service "${REPO1}Service/udp.service"

chmod +x /usr/bin/udp/udp-custom
chmod 644 /usr/bin/udp/config.json

systemctl enable udp-custom.service
systemctl start udp-custom.service

clear
print_success "UDP-Custom Installed Successfully"
}

function install_wonders(){
clear
print_install "Installing Wondershaper"
sudo apt-get install -y wondershaper
git clone https://github.com/magnific0/wondershaper.git
cd wondershaper
sudo make install
clear
print_success "Wondershaper Installed Successfully"
}

function install_rclone(){
clear
print_install "Installing RCLone"
sudo apt-get install -y rclone
wget -q ${REPO1}Files/rclone && chmod +x rclone && ./rclone
clear
print_success "RCLone Installed Successfully"
}

function install_vnstat() {
clear
print_install "Installing Vnstat"
sudo apt-get install -y vnstat libsqlite3-dev
wget -O /usr/bin/vnstat "${REPO2}vnstat"
chmod +x /usr/bin/vnstat
clear
print_success "Vnstat Installed Successfully"
}

function install_swap() {
clear
print_install "Installing 3GB Swap RAM"
dd if=/dev/zero of=/swapfile bs=1024 count=3145728
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile
swapon /swapfile
sed -i '$ i\/swapfile swap swap defaults 0 0' /etc/fstab
clear
print_success "3GB Swap RAM Installed Successfully"
}

function install_gotop() {
clear
print_install "Installing Gotop Monitoring"
wget -O /usr/bin/gotop "${REPO2}gotop"
chmod +x /usr/bin/gotop
clear
print_success "Gotop Monitoring Installed Successfully"
}

function install_bbr(){
clear
print_install "Installing TCP BBR"
wget -q ${REPO1}Files/bbr && chmod +x bbr && ./bbr
clear
print_success "TCP BBR Installed Successfully"
}

function install_iptables(){
clear
print_install "Installing Iptables"
sudo apt-get install -y iptables-persistent
wget -q ${REPO1}Files/iptables
chmod +x iptables
./iptables
clear
print_success "Iptables Installed Successfully"
}

function menu_packages() {
clear
print_install "Installing The Packages Menu"
wget -q ${REPO1}Menu/menu.zip
7z x -p@karmafc45 menu.zip > /dev/null 2>&1
chmod +x menu/*
mv menu/* /usr/local/sbin >/dev/null 2>&1
rm -r menu
rm -rf menu.zip
clear
print_success "Packages Menu Installed Successfully"
}

clear
cat >/root/.profile <<EOF
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
welcome
EOF

chmod 644 /root/.profile

cat >/etc/cron.d/xp_sc <<-END
5 0 * * * root /usr/local/bin/xp_sc
END

cat >/usr/local/bin/xp_sc <<-END
#!/bin/bash
/usr/local/sbin/expsc -r now
END

chmod +x /usr/local/bin/xp_sc

cat >/etc/cron.d/autobackup <<-END
0 19 * * * root /usr/local/bin/autobackup
END

cat >/usr/local/bin/autobackup <<-END
#!/bin/bash
/usr/local/sbin/autobackup -r now
END

chmod +x /usr/local/bin/autobackup

cat >/etc/cron.d/renew_domain <<-END
0 0 */5 * * root /usr/local/bin/renew_domain
END

cat >/usr/local/bin/renew_domain <<-END
#!/bin/bash
/usr/local/sbin/fix-domain -r now
END

chmod +x /usr/local/bin/renew_domain

cat >/etc/cron.d/xp_all <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 0 * * * root /usr/local/sbin/delexp
END

cat >/etc/cron.d/logclean <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/10 * * * * root /usr/local/sbin/clearlog
END

cat >/etc/cron.d/daily_reboot <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 5 * * * root /sbin/reboot
END

echo "*/15 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx

echo "*/15 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray

sudo service cron restart >/dev/null 2>&1

echo "/bin/false" >> /etc/shells

echo "/usr/sbin/nologin" >> /etc/shells

function restart_services() {
clear
print_install "Restarting All Services"
systemctl daemon-reload
systemctl restart ws
systemctl restart xray
systemctl restart nginx
systemctl restart squid
systemctl restart haproxy
systemctl restart dropbear
systemctl restart udp-custom
systemctl restart openvpn
systemctl restart fail2ban
systemctl restart vnstat
systemctl restart ssh
clear
print_success "All Services Successfully Restarted"
}

function install_all(){
directory_xray
directory_config
settings_debconf
setup_nginx
setup_haproxy
install_packages
install_domain
notif_autoscript
install_ssl_domain
make_folder_etc
install_xray
xray_configurations
setting_dns_resolver
settings_ssh_password
instal_ram_monitor
install_limit_ssh
install_limit_xray
install_badvpn
install_ws
install_squid
install_ohp
install_dropbear
install_sshd
install_banner
install_openvpn
install_udp
install_wonders
install_rclone
install_vnstat
install_swap
install_gotop
install_bbr
install_iptables
menu_packages
restart_services
}

install_all

rm -rf /root/domain
rm -rf /root/wondershaper
rm -rf /root/*.sh >/dev/null 2>&1
rm -rf /root/*.zip >/dev/null 2>&1

history -c
log_date_install "$(($(date +%s) - ${start}))" | tee /root/log-install.txt

clear
echo ""
echo -e "${green}Script Successfully Installed!${NC}"
echo ""
read -p "$(echo -e "Press ${YELLOW}[ ${NC}Enter${NC} ${YELLOW}]${NC} For Reboot")"
reboot
