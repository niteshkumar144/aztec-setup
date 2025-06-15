#!/bin/bash

# ===========================================================
# 🚀 AZTEC SEQUENCER NODE SETUP SCRIPT — by Nitesh Kumar 🚀
# ===========================================================

# ---------- COLORS ----------
SAFFRON='\033[38;5;208m'
WHITE='\033[1;37m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# ---------- LOGO ----------
echo -e "${CYAN}====================================================="
echo -e "${SAFFRON}███    ██ ██ ████████ ███████ ███████ ██   ██"
echo -e "${SAFFRON}████   ██ ██    ██    ██      ██      ██   ██"
echo -e "${WHITE}██ ██  ██ ██    ██    █████   ███████ ███████"
echo -e "${GREEN}██  ██ ██ ██    ██    ██           ██ ██   ██"
echo -e "${GREEN}██   ████ ██    ██    ███████ ███████ ██   ██"
echo -e "${CYAN}===================================================="
echo -e "${CYAN}   🚀 Aztec Sequencer Node Auto-Setup by Nitesh Kumar 🚀"
echo -e "${CYAN}=====================================================${NC}"

# ---------- BASIC UPDATE ----------
echo -e "${CYAN}➡️  Updating system...${NC}"
sudo apt-get update && sudo apt-get upgrade -y

# ---------- NODE.JS ----------
echo -e "${CYAN}➡️  Installing Node.js 20...${NC}"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# ---------- OTHER PACKAGES ----------
echo -e "${CYAN}➡️  Installing dependencies...${NC}"
sudo apt-get install -y curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip screen ufw

# ---------- DOCKER ----------
echo -e "${CYAN}➡️  Installing Docker & Docker Compose...${NC}"

sudo apt-get install -y apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt-get install -y docker-ce

# ✅ FIX: Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# ✅ Add user to docker group for future
sudo usermod -aG docker $USER

# ✅ Install latest Docker Compose
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo -e "${GREEN}✅ Docker Version:${NC}"
docker --version && docker-compose --version

# ---------- AZTEC CLI ----------
echo -e "${CYAN}➡️  Installing Aztec CLI...${NC}"
bash -i <(curl -s https://install.aztec.network)

echo 'export PATH="$HOME/.aztec/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

echo -e "${GREEN}✅ Aztec CLI Version:${NC}"
aztec -h

# ---------- UPDATE AZTEC VERSION ----------
echo -e "${CYAN}➡️  Setting Aztec to latest testnet version...${NC}"
aztec-up latest

# ---------- DONE ----------
echo -e "${GREEN}✅ ALL DONE! Your environment is ready!${NC}"
echo -e "${CYAN}👉 TIP: If Docker permission error comes, logout and login again or run: newgrp docker${NC}"
echo -e "${CYAN}👉 Next, start your screen and run your sequencer node as per the guide!${NC}"

echo -e "${CYAN}====================================================="
echo -e "${CYAN}🚀 Setup completed successfully — by Nitesh Kumar 🚀"
echo -e "${CYAN}=====================================================${NC}"
