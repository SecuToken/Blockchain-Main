// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SecuToken
 * @dev A simple wallet contract that allows the owner to withdraw ether
 */
contract SecuToken {
  // Address of the wallet owner
  address payable public owner;

  /**
   * @dev Sets the creator of the contract as the owner
   */
  constructor() {
      owner = payable(msg.sender);
  }

  /**
   * @dev Allows the contract to receive ether
   */
  receive() external payable {}

  /**
   * @dev Allows the owner to withdraw a specific amount of ether
   * @param _amount The amount of ether to withdraw (in wei)
   */
  function withdraw(uint _amount) external {
      require(msg.sender == owner, "Only owner can call this method");
      payable(msg.sender).transfer(_amount);
  }

  /**
   * @dev Returns the current balance of the wallet
   * @return The balance of the wallet in wei
   */
  function getBalance() external view returns (uint) {
      return address(this).balance;
  }
}
