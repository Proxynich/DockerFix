#!/bin/bash

cat << "EOF"
 /$$$$       /$$$$$$$  /$$$$$$$   /$$$$$$  /$$   /$$ /$$     /$$ /$$   /$$ /$$$$$$  /$$$$$$  /$$   /$$       /$$$$
| $$_/      | $$__  $$| $$__  $$ /$$__  $$| $$  / $$|  $$   /$$/| $$$ | $$|_  $$_/ /$$__  $$| $$  | $$      |_  $$
| $$        | $$  \ $$| $$  \ $$| $$  \ $$|  $$/ $$/ \  $$ /$$/ | $$$$| $$  | $$  | $$  \__/| $$  | $$        | $$
| $$        | $$$$$$$/| $$$$$$$/| $$  | $$ \  $$$$/   \  $$$$/  | $$ $$ $$  | $$  | $$      | $$$$$$$$        | $$
| $$        | $$____/ | $$__  $$| $$  | $$  >$$  $$    \  $$/   | $$  $$$$  | $$  | $$      | $$__  $$        | $$
| $$        | $$      | $$  \ $$| $$  | $$ /$$/\  $$    | $$    | $$\  $$$  | $$  | $$    $$| $$  | $$        | $$
| $$$$      | $$      | $$  | $$|  $$$$$$/| $$  \ $$    | $$    | $$ \  $$ /$$$$$$|  $$$$$$/| $$  | $$       /$$$$
|____/      |__/      |__/  |__/ \______/ |__/  |__/    |__/    |__/  \__/|______/ \______/ |__/  |__/      |____/
EOF

# Opening
echo ""
sed -i "s/allow-hotplug/auto/g" /etc/network/interfaces
Opening="\033[1;32mWait I'm Setting Up All for You....\033[0m"
echo -e "$Opening"

# Setup DNS
Setup_DNS="\033[1;32mSetting Up DNS\033[0m"
echo -e "$Setup_DNS"
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
echo ""

# List Source List Debian
debian11_sourcelist="deb http://kartolo.sby.datautama.net.id/debian/ bullseye main
deb-src http://kartolo.sby.datautama.net.id/debian/ bullseye main

deb http://security.debian.org/debian-security bullseye-security main contrib
deb-src http://security.debian.org/debian-security bullseye-security main contrib

deb http://kartolo.sby.datautama.net.id/debian/ bullseye-updates main contrib
deb-src http://kartolo.sby.datautama.net.id/debian/ bullseye-updates main contrib"

debian10_sourcelist="deb http://kartolo.sby.datautama.net.id/debian/ buster main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ buster-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ buster/updates main contrib non-free"

src_menu() {
    echo "Select u'r Operating System:"
    echo "1. Debian 11"
    echo "2. Debian 12"
    echo "3. Ubuntu 20.04"
    echo "Select 1,2 or 3"
    echo -n "OS: "
}

# Source List
addlist() {
    read srclist
    case $srclist in
        1)
            echo -e "\033[1;32mAdding New Source List\033[0m"
            source_list="/etc/apt/sources.list"
            echo "" > "$source_list"
            echo "$debian11_sourcelist" > "$source_list"
            echo -e "\033[1;33mSource List Updated\033[0m"
            ;;
        2)
            echo -e "\033[1;32mAdding New Source List\033[0m"
            source_list="/etc/apt/sources.list"
            echo "" > "$source_list"
            echo "$debian10_sourcelist" > "$source_list"
            echo -e "\033[1;33mSource List Updated\033[0m"
            ;;
        3)
            echo -e "\033[1;32mSource List not need to be updated\033[0m"
            echo -e "\033[1;32mSkipping to the Next step\033[0m"
            ;;
        *)
            echo -e "\033[1;31mInvalid Choice!\033[0m"
            return 1
            ;;
    esac
}
src_menu
while ! addlist; do
    src_menu
done

# Setup the System
echo ""
username=$(whoami)
echo "Your Username is: $username"
echo "Wait a second...."
apt-get install sudo -y
export PATH=/usr/bin:/sbin:/bin:/usr/sbin:/usr/local/bin
usermod -aG sudo $username
echo -e "\033[1;32mClear...\033[0m"
echo ""

# Update Package
echo -e "\033[1;32mUpdating the Package\033[0m"
sudo apt-get update -y
echo -e "\033[1;33mDone!!!\033[0m"

# Upgrading Package
echo -e "\033[1;32mUpgrading the Package\033[0m"
sudo apt-get upgrade -y
echo -e "\033[1;33mDone!!!\033[0m"

# Installing Docker
echo -e "\033[1;32mInstalling Docker\033[0m"
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "\033[1;32mDocker is Installed\033[0m"
else
    echo -e "\033[1;31mFailed to Install Docker\033[0m"
fi

# Just Kidding
echo -e "\033[1;32mPlease Fill This Field\033[0m"
echo -e "NIK:"
echo -e "No KK:"
echo "Tengkyu Ya, Mawu Ku Buat Pinjol"

# User Credential
echo ""
echo "\033[1;32mThis Username & Password will used for all container\033[0m"

# Username
echo -n "Username: "
read username
export username

# Password
echo -n "Password: "
read password
export password

# User real name
echo -n "Nama Asli: "
read namaasli
export namaasli

# Just Kidding
echo -e "\033[1;31mTengkyu ya, mau ku buat pinjol\033[0m"
echo -e "\033[1;31mBercyanda~~~~~~\033[0m"

# Database Select Menu
show_menu() {
    echo "Select what Wordpress Database:"
    echo "1. MySQL"
    echo "2. MariaDB"
    echo "Select 1 or 2"
    echo -n "Database: "
}

# Compose Proccess
process_choice() {
    read choice
    case $choice in
        1)
            echo -e "\033[1;33mBuilding Wordpress with MySQL\033[0m"
            cp mysqlscript.yml docker-compose.yml
            sed -i "s/namaasli/$namaasli/g" docker-compose.yml
            sed -i "s/wp_network_namaasli/$namaasli/g" docker-compose.yml
            sed -i "s/passwordforcontainer/$password/g" docker-compose.yml
            sed -i "s/userforcontainer/$username/g" docker-compose.yml
            docker compose up -d
            echo -e "\033[1;32mContainer is UP, access the website\033[0m"
            echo "Kamu tau Kan IP Mu sendiri, dah yak Bye Bye. Love U All"
            ;;
        2)
            echo -e "\033[1;33mBuilding Wordpress with MariaDB\033[0m"
            cp mariadbscript.yml docker-compose.yml
            sed -i "s/namaasli/$namaasli/g" docker-compose.yml
            sed -i "s/wp_network_namaasli/$namaasli/g" docker-compose.yml
            sed -i "s/passwordforcontainer/$password/g" docker-compose.yml
            sed -i "s/userforcontainer/$username/g" docker-compose.yml
            docker compose up -d
            echo -e "\033[1;32mContainer is UP, access the website\033[0m"
            echo "Kamu tau Kan IP Mu sendiri, dah yak Bye Bye. Love U All"
            ;;
        *)
            echo -e "\033[1;31mInvalid Choice!\033[0m"
            return 1
            ;;
    esac
}   
show_menu
while ! process_choice; do
    show_menu
done

# Login Information
echo ""
echo "-----------------------------"
echo "Information !!!"
echo "Username: $username"
echo "Password: $password"
echo "Port Wordpress: 80"
echo "Port PhpMyAdmin: 8080"
echo "-----------------------------"
echo ""

echo "Aku tau kalo kamu $namaasli"
echo "Minimal bilang makasih lah ya ke yang buat alat ini hehe"
echo ""

cat << "HEO"
 ______  ____  ____  ________   ______  ____  ____  ________     _  ______   
|_   _ \|_  _||_  _||_   __  | |_   _ \|_  _||_  _||_   __  |   / // ____ `. 
  | |_) | \ \  / /    | |_ \_|   | |_) | \ \  / /    | |_ \_|  / / `'  __) | 
  |  __'.  \ \/ /     |  _| _    |  __'.  \ \/ /     |  _| _  < <  _  |__ '. 
 _| |__) | _|  |_    _| |__/ |  _| |__) | _|  |_    _| |__/ |  \ \| \____) | 
|_______/ |______|  |________| |_______/ |______|  |________|   \_\\______.' 
HEO