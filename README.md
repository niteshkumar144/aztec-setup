# Aztec Sequencer Node Setup 🚀

A step-by-step, beginner-friendly guide to run your **Aztec Sequencer Node**, written by **Nitesh Kumar**.

---

## 🖥️ System Requirements

- **OS:** Ubuntu 20.04 or newer (VPS recommended)
- **CPU:** 4 cores minimum
- **RAM:** 8GB minimum
- **Disk:** 100GB SSD recommended
- **Network:** Stable internet connection

If you're using your personal computer, make sure **Docker** stays running in the background.

---

## ✅ What You Need Before Starting

1️⃣ **Docker & Docker Compose**\
These handle the containers your node needs.

2️⃣ **Aztec CLI**\
Installed automatically with the script below.

3️⃣ **Sepolia RPC & Beacon RPC**\
Get free RPC endpoints from trusted sites:

- [Alchemy](https://www.alchemy.com/)
- [Infura](https://www.infura.io/)
- [QuickNode](https://www.quicknode.com/)

4️⃣ **Sepolia Test ETH**\
You need a small balance to run the sequencer. Get free test ETH from:

- [Alchemy Sepolia Faucet](https://www.alchemy.com/faucets/ethereum-sepolia)
- [Chainlink Faucet](https://faucets.chain.link/sepolia)
- [QuickNode Faucet](https://faucet.quicknode.com/ethereum/sepolia)

5️⃣ **Wallet Address & Private Key**\
Use a test wallet only. Never use your main wallet key!

---

## ⚡ Install Everything Automatically

Run this command in your terminal:

```bash
curl -s https://raw.githubusercontent.com/niteshkumar144/aztec-setup/main/aztec.sh | bash
```

**➡️ Note: If ask Overwrite? (y/N)   
✅  Choose y and Press Enter**

**➡️This installs Node.js, Docker, Docker Compose, and the Aztec CLI.**

---

## 📡 Start a Screen Session

Run:

```bash
screen -S aztec
```

**Why?** This keeps your node running even if you close your terminal.

---

## 🚀 Run Your Aztec Sequencer Node

Replace the placeholders with your info:

```bash
aztec start --node --archiver --sequencer \
  --network alpha-testnet \
  --l1-rpc-urls YOUR_ETH_SEPOLIA_RPC \
  --l1-consensus-host-urls YOUR_BEACON_SEPOLIA_RPC \
  --sequencer.validatorPrivateKey 0xYOUR_PRIVATE_KEY \
  --sequencer.coinbase YOUR_EVM_ADDRESS \
  --p2p.p2pIp YOUR_EXTERNAL_IP
```

## 🗒️ Replace with Your Own

| Placeholder              | What to use                           |
| ------------------------ | -------------------------------------- |
| `YOUR_ETH_SEPOLIA_RPC`   | Your own Sepolia RPC URL               |
| `YOUR_BEACON_SEPOLIA_RPC`| Your Beacon Chain RPC URL               |
| `0xYOUR_PRIVATE_KEY`     | Your EVM wallet private key (must start with `0x`) |
| `YOUR_EVM_ADDRESS`       | Your wallet’s address                  |
| `YOUR_EXTERNAL_IP`       | Your server’s external IP (`curl ifconfig.me`) |

---

👇 **How to get your external IP:**

```bash
curl ifconfig.me
```

---

## ✅ What a Successful Run Looks Like

When working correctly, you’ll see messages like:


✔ Node started successfully

✔ Archiver syncing

✔ Sequencer producing blocks

✔ P2P connected


![Screenshot 2025-06-15 114600](https://github.com/user-attachments/assets/aa4f26fa-7549-4e1b-9c74-cdac5153c364)


---

## ⚙️ Helpful Commands

| Command              | What It Does                |
| -------------------- | --------------------------- |
| `screen -S aztec`    | Start a screen session      |
| `CTRL + A`, then `D` | Detach safely               |
| `screen -r aztec`    | Reconnect to your session   |
| `curl ifconfig.me`   | Show your public IP address |

---

## ➡️ How To Get Peer Id: 
``` bash 
sudo docker logs $(docker ps -q --filter ancestor=aztecprotocol/aztec:latest | head -n 1) 2>&1 | grep -i "peerId" | grep -o '"peerId":"[^"]*"' | cut -d'"' -f4 | head -n 1`
```

---

## 🙏 Made with ❤️ by Nitesh Kumawat

If this helped, star the repo ⭐ and share with the community.

Thank You ❤️ & Jai Hind Vande Matram! 🇮🇳

