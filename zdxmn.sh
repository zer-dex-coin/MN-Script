#!/usr/bin/env bash

#:: Zer-Dex team
#:: Copyright // 2019-10-05
cat << "ZDX"

ZDX

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo $(date)
echo ""
echo "Good day. This is automated cold masternode setup for Zer-Dex project. Auto installer was tested on specific environment. Don't try to install masternode with undocumented operating system!"
echo ""
echo "Installation content:"
echo "Zer-Dex core"
echo
echo "Setup can be launched"
echo "Do you agree?"
echo -e "${GREEN}(y)es${NC}/${RED}(n)o"${NC}?
read agree
            if [ "$agree" != "y" ]; then
               echo "Setup canceled" && exit 1
            fi
OS_version=$(cat /etc/lsb-release | grep -c bionic)
OS_version2=$(cat /etc/lsb-release | grep -c xenial)
            if [ "$OS_version" -ne "1" ]; then
                    echo ""
			echo -e "${RED}Looks like your OS version is not Ubuntu 18.04 Bionic //${GREEN} Maybe Ubuntu 16.04 Xenial? - Checking...${NC}"

                        if [ "$OS_version2" -eq "1" ]; then
                                echo ""
                        else
                                echo ""
                                echo -e "${RED}Looks like your OS version is not Ubuntu 16.04 Xenial or Ubuntu 18.04 Bionic${NC}" && exit 1
                        fi
            fi
sudo apt-get update -y
if [ $? -ne "0" ]; then echo -e "${RED}Cannot update ubuntu repos${NC}" && exit 1; fi
sudo apt-get install software-properties-common -y 1> /dev/null
if [ $? -ne "0" ]; then echo -e "${RED}Unable to install software-properties-common${NC}" && exit 1; fi
sudo add-apt-repository universe -y 1> /dev/null
if [ $? -ne "0" ]; then echo -e "${RED}Unable to add repository universe${NC}" && exit 1; fi
sudo apt-get install dnsutils jq curl -y 1> /dev/null
if [ $? -ne "0" ]; then echo -e "${RED}Unable to install dnsutils jq curl${NC}" && exit 1; fi
echo ""
wanip=$(curl -s 4.ipquail.com/ip)
if [ -z "${wanip}" ]; then
    echo -e "${RED}Sorry, we don't know your external IPv4 addr${NC}" && echo ""
    echo -e "${GREEN}Input your IPv4 addr manually:${NC}" && read wanip
fi
echo "Your external IP is $wanip"
echo -e "${GREEN}(y)es${NC}/${RED}(n)o"${NC}
read wan
            if [ "$wan" != "y" ]; then
               echo -e "${RED}Sorry, we don't know your external IPv4 addr${NC}" && exit 1
            fi
# Check install or update for Bionic //
[ -f /etc/apt/sources.list.d/bitcoin-ubuntu-bitcoin-bionic.list ]
            if [ "$?" -eq "0" ]; then
                    echo ""
                    echo -e "Looks like you are trying to setup second time? You need fresh ${GREEN}(i)nstall${NC} or ${RED}(u)pdate${NC} your MN?"
					echo -e "${GREEN}i${NC}/${RED}u"${NC}?
					read setorupd
					if [ "$setorupd" = "u" ]; then
					sudo systemctl stop zdxcore &&
					echo -e "${GREEN}1/5 Zer-Dex service is stopped${NC}" &&
					cd /usr/bin &&
					sudo rm -fr zdx-cli zdxd &&
					cd ~ &&
					sudo rm -fr zdx-cli zdxd zdx-tx ZDXCore ZDXCore.ubuntu18.04.zip &&
					echo -e "${GREEN}2/5 Old Zer-Dex wallet is deleted${NC}" &&
					wget https://github.com/zer-dex-coin/zerdex-core/releases/download/1.0.0.2/ZDXCore.ubuntu18.04.zip &&
					echo -e "${GREEN}3/5 Zer-Dex wallet is downloaded${NC}" &&
					unzip -o ZDXCore*.zip &&
					sudo cp -fr ZDXCore/zdx-cli ZDXCore/zdxd /usr/bin/ &&
					sudo rm -fr ZDXCore zdx-cli zdxd zdx-tx zdx-qt ZDXCore.ubuntu18.04.zip &&
					cd /usr/bin &&
					sudo chmod -R 755 zdx-cli zdxd &&
					cd ~ &&
					echo -e "${GREEN}4/5 Zer-Dex wallet is updated${NC}" &&
					sudo systemctl start zdxcore &&
					echo -e "${GREEN}5/5 Zer-Dex service is started${NC}" &&
					echo -e "${GREEN}Update is full completed.${NC}" && exit 1; fi
					if [ "$setorupd" = "i" ]; then
					sudo systemctl stop zdxcore &&
					echo "" &&
					echo -e "${GREEN}Setup Zer-Dex masternode started${NC}" &&
					sleep 5
					else
					echo "" &&
					echo -e "${RED}Sorry, we cannot continue${NC}" && exit 1;   fi
			fi
			
			
# Check install or update for Xenial //
[ -f /etc/apt/sources.list.d/bitcoin-ubuntu-bitcoin-xenial.list ]
            if [ "$?" -eq "0" ]; then
                    echo ""
                    echo -e "Looks like you are trying to setup second time? You need fresh ${GREEN}(i)nstall${NC} or ${RED}(u)pdate${NC} your MN?"
					echo -e "${GREEN}i${NC}/${RED}u"${NC}?
					read setorupd
					if [ "$setorupd" = "u" ]; then
					sudo systemctl stop zdxcore &&
					echo -e "${GREEN}1/5 Zer-Dex service is stopped${NC}" &&
					cd /usr/bin &&
					sudo rm -fr zdx-cli zdxd &&
					cd ~ &&
					sudo rm -fr ZDXCore zdx-cli zdxd zdx-tx ZDXCore.ubuntu16.04.zip &&
					echo -e "${GREEN}2/5 Old Zer-Dex wallet is deleted${NC}" &&
					wget https://github.com/zer-dex-coin/zerdex-core/releases/download/1.0.0.2/ZDXCore.ubuntu16.04.zip &&
					echo -e "${GREEN}3/5 Zer-Dex wallet is downloaded${NC}" &&
					unzip -o ZDXCore*.zip &&
					sudo cp -fr ZDXCore/zdx-cli ZDXCore/zdxd /usr/bin/ &&
					sudo rm -fr ZDXCore zdx-cli zdxd zdx-tx zdx-qt ZDXCore.ubuntu16.04.zip &&
					cd /usr/bin &&
					sudo chmod -R 755 zdx-cli zdxd &&
					cd ~ &&
					echo -e "${GREEN}4/5 Zer-Dex wallet is updated${NC}" &&
					sudo systemctl start zdxcore &&
					echo -e "${GREEN}5/5 Zer-Dex service is started${NC}" &&
					echo -e "${GREEN}Update is full completed.${NC}" && exit 1; fi
					if [ "$setorupd" = "i" ]; then
					sudo systemctl stop zdxcore &&
					echo "" &&
					echo -e "${GREEN}Setup Zer-Dex masternode started${NC}" &&
					sleep 5
					else
					echo "" &&
					echo -e "${RED}Sorry, we cannot continue${NC}" && exit 1;   fi
            
			fi
if [ "$OS_version" -eq "1" ]; then
# Install dep. for Bionic //
        sudo add-apt-repository ppa:bitcoin/bitcoin -y
	if [ $? -ne "0" ]; then echo "Unable to add bitcoin dependencies" && exit 1; fi
        sudo apt-get update -y
	if [ $? -ne "0" ]; then echo "Cannot update ubuntu repos" && exit 1; fi
        sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
	if [ $? -ne "0" ]; then echo "Unable to install libdb dependencies" && exit 1; fi
        sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common libminiupnpc-dev libcrypto++-dev libboost-all-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libboost-filesystem-dev libboost-thread-dev libssl-dev libssl-dev software-properties-common unzip libzmq3-dev ufw wget git python-openssl -y
		if [ $? -ne "0" ]; then echo "Unable to install major dependencies" && exit 1; fi
		sudo wget https://github.com/zer-dex-coin/MN-Script/blob/master/libs.zip
		unzip -o libs.zip
		sudo cp -fr libboost_filesystem.so.1.58.0 libboost_chrono.so.1.58.0 libboost_program_options.so.1.58.0 libboost_system.so.1.58.0 libboost_thread.so.1.58.0 libminiupnpc.so.10 libevent_core-2.0.so.5 libevent_pthreads-2.0.so.5 libevent-2.0.so.5 /usr/lib/
		sudo rm -fr libboost_filesystem.so.1.58.0 libboost_chrono.so.1.58.0 libboost_program_options.so.1.58.0 libboost_system.so.1.58.0 libboost_thread.so.1.58.0 libminiupnpc.so.10 libevent_core-2.0.so.5 libevent_pthreads-2.0.so.5 libevent-2.0.so.5 libs.zip
        if [ $? -ne "0" ]; then echo "Unable to install libboost dependencies" && exit 1; fi
        else
# Install dep. for Xenial //		
        sudo add-apt-repository ppa:bitcoin/bitcoin -y
        if [ $? -ne "0" ]; then echo "Unable to add bitcoin dependencies" && exit 1; fi
        sudo apt-get update -y
        if [ $? -ne "0" ]; then echo "Cannot update ubuntu repos" && exit 1; fi
        sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
        if [ $? -ne "0" ]; then echo "Unable to install libdb dependencies" && exit 1; fi
        sudo apt-get install libboost-system1.58-dev libboost-system1.58.0 -y
        if [ $? -ne "0" ]; then echo "Unable to install libboost dependencies" && exit 1; fi
        sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-pthreads-2.0-5 libevent-dev bsdmainutils software-properties-common libminiupnpc-dev libcrypto++-dev libboost-all-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libboost-filesystem-dev libboost-thread-dev libssl-dev libssl-dev software-properties-common unzip libzmq3-dev ufw wget git python-openssl -y
        if [ $? -ne "0" ]; then echo "Unable to install major dependencies" && exit 1; fi
        fi
# Download ZDX sources //
echo ""
echo -e "${GREEN}1/6 Downloading Zer-Dex sources...${NC}" 
echo ""
cd /usr/bin
sudo rm -fr zdx-cli zdxd
cd ~/.ZDXCore
sudo rm -R -fr database .lock peers.dat blocks db.log masternode.conf zdx.conf zerocoin budget.dat debug.log mncache.dat zdxd.pid chainstate fee_estimates.dat mnpayments.dat sporks
cd ~
sudo rm -fr ZDXCore*.zip
sudo rm -R -fr ZDXCore.ubuntu18.04

            if [ "$OS_version" -eq "1" ]; then
                wget https://github.com/zer-dex-coin/zerdex-core/releases/download/1.0.0.2/ZDXCore.ubuntu18.04.zip
		if [ $? -ne "0" ]; then echo "Failed to download zdxd binary" && exit 1; fi
            elif [ "$OS_version2" -eq "1" ]; then
                wget https://github.com/zer-dex-coin/zerdex-core/releases/download/1.0.0.2/ZDXCore.ubuntu16.04.zip
		if [ $? -ne "0" ]; then echo "Failed to download zdxd binary" && exit 1; fi
            fi
# Manage coin daemon and configuration //
unzip -o ZDXCore*.zip
echo ""
sudo cp -fr ZDXCore/zdx-cli ZDXCore/zdxd /usr/bin/
sudo rm -fr ZDXCore zdx-cli zdxd zdx-tx zdx-qt ZDXCore.ubuntu18.04.zip ZDXCore.ubuntu16.04.zip
cd /usr/bin
sudo chmod -R 755 zdx-cli zdxd
cd ~
sudo mkdir -p ~/.ZDXCore/
sudo touch ~/.ZDXCore/zdx.conf
sudo cat << EOF > ~/.ZDXCore/zdx.conf
rpcuser=zdxuser
rpcpassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')
txindex=1
rpcport=31292
listen=1
port=19849
rpcallowip=127.0.0.1
daemon=1
masternode=1


EOF

#Create zdx.service
echo -e "${GREEN}2/6 Create zdx.service for systemd${NC}"
echo ""
echo \
"[Unit]
Description=Zer-Dex Core daemon & service
After=network.target

[Service]
User=root
Type=forking
ExecStart=/usr/bin/zdxd -daemon -pid=$(echo $HOME)/.ZDXCore/zdxd.pid --datadir=$(echo $HOME)/.ZDXCore/
PIDFile=$(echo $HOME)/.ZDXCore/zdxd.pid
ExecStop=/usr/bin/zdx-cli stop
Restart=always
RestartSec=3600
TimeoutStopSec=60s
TimeoutStartSec=10s
StartLimitInterval=120s
StartLimitBurst=5

[Install]
WantedBy=default.target" | sudo tee /etc/systemd/system/zdxcore.service

sudo chmod 664 /etc/systemd/system/zdxcore.service

sudo systemctl enable zdxcore

real_user=$(echo $USER) 

sudo chown -R $real_user:$real_user $(echo $HOME)/.ZDXCore/

# Check if user is root? If not create sudoers files to manage systemd services
echo ""
echo -e "${GREEN}3/6 Check if user is root? If not create sudoers files to manage systemd services${NC}"
if [ "$EUID" -ne 0 ]; then
sudo echo \
"%$real_user ALL= NOPASSWD: /bin/systemctl start zdxcore
%$real_user ALL= NOPASSWD: /bin/systemctl stop zdxcore
%$real_user ALL= NOPASSWD: /bin/systemctl restart zdxcore" | sudo tee /tmp/$real_user
sudo mv /tmp/$(echo $real_user) /etc/sudoers.d/
fi

# Start zdx daemon, wait for wallet creation //
sudo systemctl start zdxcore &&
echo "" ; echo "Please wait for few minutes..."
sleep 12 &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
echo ""
sudo systemctl stop zdxcore &&
echo ""
echo -e "Shutting down daemon, reconfiguring zdx.conf, we want to know your cold wallet ${GREEN}masternodeprivkey${NC} (example: 7UwDGWAKNCAvyy9MFEnrf4JBBL2aVaDm2QzXqCQzAugULf7PUFD), please input now:"
echo""
read masternodeprivkey
privkey=$(echo $masternodeprivkey)
checkpriv_key=$(echo $masternodeprivkey | wc -c)
if [ "$checkpriv_key" -ne "52" ];
then
	echo ""
	echo "Looks like your $privkey is not correct, it should cointain 52 symbols, please paste it one more time"
	read masternodeprivkey
privkey=$(echo $masternodeprivkey)
checkpriv_key=$(echo $masternodeprivkey | wc -c)

if [ "$checkpriv_key" -ne "52" ];
then
        echo "Something wrong with masternodeprivkey, cannot continue" && exit 1
fi
fi
echo ""
echo "Give some time to shutdown the wallet..."
echo ""
sleep 15 &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
sudo cat << EOF > ~/.ZDXCore/zdx.conf
rpcuser=zdxuser
rpcpassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')
txindex=1
rpcport=31292
listen=1
port=19849
rpcallowip=127.0.0.1
daemon=1
masternode=1
masternodeaddr=$wanip
masternodeprivkey=$privkey


EOF

# Firewall //
echo -e "${GREEN}4/6 Update firewall rules${NC}"
echo ""
echo "Update firewall rules"
sudo /usr/sbin/ufw limit ssh/tcp comment 'Rate limit for openssh server' 
sudo /usr/sbin/ufw allow 19849/tcp comment 'Zer-Dex Wallet daemon'
sudo /usr/sbin/ufw --force enable
echo ""

# Fast download Blockchain
cd ~
cd .ZDXCore
sudo rm -R blocks chainstate
echo ""
echo -e "${GREEN}5/6 please wait, installation script downloads Zer-Dex blockchain ${NC}"
echo ""
wget https://github.com/zer-dex-coin/zerdex-core/releases/download/1.0.0.2/bootstrap.211k.blocks.zip
unzip -o bootstrap.211k.blocks.zip
sudo rm -f  bootstrap.211k.blocks.zip

# Final start
echo ""
echo -e "${GREEN}6/6 Masternode config done, Zer-Dex wallet installed - starting again${NC}"
echo ""
sudo systemctl start zdxcore
echo -e "${RED}The blockchain is syncing from scratch. You have to wait few hours to sync all the blocks!${NC}"
echo ""
echo "Setup summary:"
echo "Masternode privkey: $privkey"
echo "Your external IPv4 addr: $wanip"
echo "Installation log: ~/zdx_masternode_installation.log"
echo "Zer-Dex Core datadir: "$(echo $HOME/.ZDXCore/)""
echo ""
echo -e "Need additional help? Please visit Zer-Dex Discord channel{NC}"
echo ""
