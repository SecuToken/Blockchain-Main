
# SecuToken - CVE-Based Rewards via Smart Contract on Private PoA Ethereum Network

SecuToken is a custom ERC-20 smart contract designed to enable structured token-based rewards for users who disclose software vulnerabilities, categorised by severity. It is deployed on a private PoA Ethereum blockchain using Geth (Go Ethereum) and Truffle, with full control over token issuance, transfers, and payout logic.

## 📌 Overview

This project was developed as part of a blockchain-focused implementation using a private Ethereum network. The key objective was to demonstrate how a custom smart contract (SecuToken) could be used to reward ethical hackers or users who report Common Vulnerabilities and Exposures (CVEs) based on severity through tokens on a blockchain.

All development was completed locally using:

- Geth (v1.13.15)
- Truffle Suite
  - Truffle (v5.11.5)
  - Ganache (v7.9.1)
- Solidity (v0.8.19)
- Node (v18.19.0)
- OpenZeppelin (v4.9.3)

## Features

- ✅ ERC-20 Token named "SecuToken" (symbol: SKTN)
- ✅ Role-based access control (Admin and Treasurer roles)
- ✅ Custom rewards mapped to vulnerability severity:
  - Low, Medium, High, Critical
- ✅ On-chain reward disbursement with logging
- ✅ Bulk reward issuance for multiple severities
- ✅ Pausable contract for emergency halts
- ✅ Deposit mechanism to fund the contract

## 🔒 Smart Contract Role Architecture

| Role            | Purpose                                 |
|-----------------|------------------------------------------|
| Admin           | Can pause/unpause the contract and set severity payouts |
| Treasurer       | Authorised to reward users and distribute SKTN & By default, is applied to the Admin Role |

## 🧠 How It Works

1. The contract is initialised with 1,000,000 SKTN tokens minted to the Admin.
2. Admin assigns severity levels to corresponding reward amounts using setSeverityReward.
3. Tokens are transferred into the contract via depositToContract.
4. The Admin/Treasurer can then distribute tokens using:
   - rewardUserBySeverity: issues reward based on one severity level.
   - rewardUserBulk: issues a single reward based on multiple severities.
5. The contract can be paused/unpaused in case of misuse or errors.

All transfers emit events for transparency and auditing through the truffle console.

## 🧪 Local Deployment

To deploy and test our pre-made PoA Blockchain network:

1. Clone this repo and run:

```bash
git clone https://github.com/SecuToken/Blockchain-Main.git
```

2. Install Needed Package

```bash
cd /Packages
npm install
```

3. Follow the Manuals & Usage Documentation located under the ***Geth & Truffle Manuals*** directory!

## ⚠️ IMPORTANT

**Note:** 
<br> Please do not use this project for real-world Deployment or Production Use. <br> This project is intended for educational and demonstration purposes only. 
