#!/bin/bash

# ============================================================
# 🚀 AZTEC SEQUENCER NODE SETUP BY NITESH KUMAR 🚀
# ============================================================

# Colors
CYAN='\033[1;36m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "${CYAN}====================================================="
echo -e "   🚀 Aztec Sequencer Node Setup by NITESH KUMAR 🚀"
echo -e "=====================================================${NC}"

echo "-------------------------------"
echo " Updating & Installing Packages"
echo "-------------------------------"

sudo apt-get update && sudo apt-get upgrade -y

echo "-------------------------------"
echo " Installing Node.js 20..."
echo "-------------------------------"

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "-------------------------------"
echo " Installing Utilities & Docker..."
echo "-------------------------------"

sudo apt install -y curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip screen ufw apt-transport-https ca-certificates software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt install -y docker-ce

sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group
sudo usermod -aG docker $USER

echo "-------------------------------"
echo "✅ Docker Version:"
docker --version
docker compose version

echo "====================================================="
echo "✅ BASIC SETUP DONE!"
echo "====================================================="

echo "👉 IMPORTANT: To complete Aztec CLI install, please:"
echo "  1) Logout & login again  (OR run: newgrp docker)"
echo "  2) Then run: bash -i <(curl -s https://install.aztec.network)"
echo "  3) Then run: aztec-up latest"
echo ""
echo "🚀 All other steps are ready — see README for next commands."
echo "====================================================="
echo "🔥 By Nitesh Kumar — Happy Sequencing!"
echo "====================================================="
