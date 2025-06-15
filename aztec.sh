#!/bin/bash

# ============================================================
# 🚀 AZTEC SEQUENCER NODE SETUP BY NITESH KUMAR 🚀
# ============================================================

# Colors
SAFFRON='\033[38;5;208m'
WHITE='\033[1;37m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

echo -e "${CYAN}====================================================="
echo -e "${SAFFRON}███    ██ ██ ████████ ███████ ███████ ██   ██ "
echo -e "${SAFFRON}████   ██ ██    ██    ██      ██      ██   ██ "
echo -e "${WHITE}██ ██  ██ ██    ██    █████   ███████ ███████ "
echo -e "${GREEN}██  ██ ██ ██    ██    ██           ██ ██   ██ "
echo -e "${GREEN}██   ████ ██    ██    ███████ ███████ ██   ██ "
echo -e "${CYAN}===================================================="
echo -e "${CYAN}      🚀 Aztec Sequencer Node Setup by NITESH 🚀"
echo -e "${CYAN}=====================================================${NC}"

# ---------------------------

echo "-------------------------------"
echo " Updating & Upgrading System..."
echo "-------------------------------"

sudo apt-get update && sudo apt-get upgrade -y

echo "-------------------------------"
echo " Installing Node.js 20..."
echo "-------------------------------"

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "-------------------------------"
echo " Installing Other Packages..."
echo "-------------------------------"

sudo apt install -y curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip screen ufw

echo "-------------------------------"
echo " Installing Docker & Docker Compose..."
echo "-------------------------------"

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Wait for Docker to be ready
echo "-------------------------------"
echo " Checking if Docker daemon is running..."
echo "-------------------------------"
while ! docker info > /dev/null 2>&1; do
  echo "⏳ Waiting for Docker to start..."
  sleep 2
done
echo "✅ Docker is running!"

# Add current user to docker group
sudo usermod -aG docker $USER

echo "-------------------------------"
echo " Verifying Docker Installation..."
echo "-------------------------------"
docker --version
docker compose version

echo "-------------------------------"
echo " Installing Aztec CLI..."
echo "-------------------------------"

bash -i <(curl -s https://install.aztec.network)

echo 'export PATH="$HOME/.aztec/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

echo "-------------------------------"
echo " Aztec CLI Version Check:"
aztec -h || echo "👉 If you see 'command not found', please logout and login again to refresh permissions."

echo "-------------------------------"
echo " Setting Aztec to latest version for testnet..."
aztec-up latest || echo "👉 Make sure Docker is running. Restart your terminal if needed."

echo "====================================================="
echo "✅ ALL DONE! Your environment is ready!"
echo "👉 TIP: If Docker permission error comes, logout and login again or run: newgrp docker"
echo "👉 Next, start your screen and run your sequencer node as per the guide!"
echo "====================================================="
echo "🚀 Setup completed successfully — by Nitesh Kumar 🚀"
echo "====================================================="
