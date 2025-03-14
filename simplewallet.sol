@ -1,20 +1,68 @@
// SPDX-License-Identifier: MIT
// This line specifies the license under which this code is released - MIT is a permissive open source license

pragma solidity ^0.8.11;
// This line specifies the Solidity compiler version to use - must be at least 0.8.11 but can be higher

/**
 * @title EtherWallet
 * @dev A simple Ethereum wallet contract that allows:
 *      - Storing Ether in the contract
 *      - Withdrawing Ether (owner only)
 *      - Checking the contract's balance
 */
contract EtherWallet {
    address payable public owner;
  // State variable to store the owner's address
  // 'payable' means this address can receive Ether
  // 'public' automatically creates a getter function to read this variable
  address payable public owner;

  /**
   * @dev Constructor - runs once when the contract is deployed
   * Sets the contract deployer (msg.sender) as the owner of the wallet
   */
  constructor() {
      // msg.sender is the address that deploys the contract
      // We cast it to payable to allow it to receive Ether
      owner = payable(msg.sender);
  }

    constructor() {
        owner = payable (msg.sender);
    }
    receive() external payable {}
  /**
   * @dev Special function that runs when Ether is sent to the contract address
   * The 'receive' function is a special function in Solidity that:
   * - Has no function name or arguments
   * - Must be 'external' and 'payable'
   * - Is executed when the contract receives Ether with no data (calldata)
   */
  receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "Only owner can call this method");
        payable(msg.sender).transfer(_amount);
    }
  /**
   * @dev Allows the owner to withdraw a specific amount of Ether from the contract
   * @param _amount The amount of Ether to withdraw (in wei)
   * 
   * Security features:
   * - Only the owner can call this function (enforced by require statement)
   * - If the contract doesn't have enough balance, the transfer will fail automatically
   */
  function withdraw(uint _amount) external {
      // Check that only the owner is calling this function
      require(msg.sender == owner, "Only owner can call this method");
      
      // Transfer the specified amount to the sender (who we've verified is the owner)
      // If this fails (e.g., due to insufficient balance), the transaction will revert
      payable(msg.sender).transfer(_amount);
  }

    function getBalance() external view returns (uint) {
        return address (this).balance;
    }
}
  /**
   * @dev Returns the current balance of the contract in wei
   * @return The contract's balance in wei (1 Ether = 10^18 wei)
   * 
   * 'view' means this function doesn't modify state, only reads it
   * This makes it free to call (no gas cost) when called externally
   */
  function getBalance() external view returns (uint) {
      // address(this) refers to the contract's own address
      // .balance is a built-in property that returns the Ether balance
      return address(this).balance;
  }
}