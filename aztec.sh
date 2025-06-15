#!/bin/bash

# ============================================================
# 🚀 AZTEC SEQUENCER NODE AUTO SETUP SCRIPT by NITESH 🚀
# Compatible: Ubuntu 20.04/22.04
# ============================================================

# ---------- Colors ----------
ORANGE='\033[38;5;208m'
WHITE='\033[1;37m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
RED='\033[1;31m'
NC='\033[0m' # Reset

# ---------- Banner ----------
clear
echo -e "${CYAN}============================================================"
echo -e "${ORANGE}███    ██ ██ ████████ ███████ ███████ ██   ██ "
echo -e "${ORANGE}████   ██ ██    ██    ██      ██      ██   ██ "
echo -e "${WHITE}██ ██  ██ ██    ██    █████   ███████ ███████ "
echo -e "${GREEN}██  ██ ██ ██    ██    ██           ██ ██   ██ "
echo -e "${GREEN}██   ████ ██    ██    ███████ ███████ ██   ██ "
echo -e "${CYAN}============================================================"
echo -e "${CYAN}         🚀 Aztec Sequencer Node Auto Setup by NITESH 🚀"
echo -e "${CYAN}============================================================${NC}"

# ---------- Functions ----------
check_error() {
  if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Error occurred. Exiting...${NC}"
    exit 1
  fi
}

# ---------- Update & Upgrade ----------
echo -e "${CYAN}➡️  Updating and Upgrading your system...${NC}"
sudo apt-get update && sudo apt-get upgrade -y
check_error

# ---------- Install Node.js ----------
echo -e "${CYAN}➡️  Installing Node.js 20.x ...${NC}"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
check_error

# ---------- Install Essential Packages ----------
echo -e "${CYAN}➡️  Installing essential packages...${NC}"
sudo apt-get install -y curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip screen ufw
check_error

# ---------- Install Docker & Docker Compose ----------
echo -e "${CYAN}➡️  Installing Docker and Docker Compose...${NC}"
sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce && sudo systemctl enable --now docker
sudo usermod -aG docker $USER && newgrp docker
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker Installation

docker --version && docker-compose --version
check_error

# ---------- Install Aztec CLI ----------
echo -e "${CYAN}➡️  Installing Aztec CLI...${NC}"
bash -i <(curl -s https://install.aztec.network)
check_error

echo 'export PATH="$HOME/.aztec/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

aztec -h
check_error

# ---------- Set Aztec Latest Version ----------
echo -e "${CYAN}➡️  Setting Aztec to latest version for testnet...${NC}"
aztec-up latest
check_error

# ---------- Finished ----------
echo -e "${GREEN}✅ ALL DONE! Your system is ready for Aztec Sequencer Node.${NC}"
echo -e "${CYAN}============================================================${NC}"
echo -e "${WHITE}💡 NEXT STEPS:"
echo -e "1️⃣  Create a screen session: ${GREEN}screen -S aztec${NC}"
echo -e "2️⃣  Start your node (replace values!):"
echo -e ""
echo -e "${ORANGE}aztec start --node --archiver --sequencer \\"
echo -e "  --network alpha-testnet \\"
echo -e "  --l1-rpc-urls YOUR_ETH_SEPOLIA_RPC \\"
echo -e "  --l1-consensus-host-urls YOUR_BEACON_SEPOLIA_RPC \\"
echo -e "  --sequencer.validatorPrivateKey 0xYOUR_PRIVATE_KEY \\"
echo -e "  --sequencer.coinbase YOUR_EVM_ADDRESS \\"
echo -e "  --p2p.p2pIp YOUR_EXTERNAL_IP${NC}"
echo -e ""
echo -e "${WHITE}3️⃣  Get your External IP: ${GREEN}curl ifconfig.me${NC}"
echo -e "${WHITE}4️⃣  To detach screen: ${GREEN}Ctrl + A then D${NC}"
echo -e "${WHITE}5️⃣  To reattach screen: ${GREEN}screen -r aztec${NC}"
echo -e "${CYAN}============================================================${NC}"
echo -e "${GREEN}🚀 Happy Node Running! - NITESH${NC}"
