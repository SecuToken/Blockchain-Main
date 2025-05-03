module.exports = {

  networks: {

    development: {
      host: "127.0.0.1", // Geth node running locally
      port: 8545,        // HTTP-RPC port (make sure it’s enabled)
      network_id: "2025", // Your private network ID
      gas: 5000000, // Maximum Gas Limit, high enough to cover the gas used by the transaction but not exceed block gas limit in genesis.json
      gasPrice: 1000000000, // 1 Ether in Gwei Currency, going as low as possible for PoA network
      from: "0x3B663aAb4fdd872C5B79882eef7159B9C11e0b52" // Account address (Set to SecuToken ADMIN to absorb the Gas fees)
     },

  },

  // Configure compiler
  compilers: {
    solc: {
      version: "0.8.19",      // Fetch exact version from solc-bin
    }
  },

};
