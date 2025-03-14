// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/**
 * @title SimpleWallet
 * @author Modified version
 * @notice A basic wallet for storing and managing Ethereum
 * @dev Provides functionality for:
 *      1. Depositing ETH into the contract
 *      2. Allowing the administrator to withdraw funds
 *      3. Querying the wallet's current ETH balance
 */
contract SimpleWallet {
    // The wallet administrator who has withdrawal rights
    // Marked as payable to enable ETH transfers to this address
    address payable public administrator;
    
    // Emitted when funds are withdrawn from the wallet
    event Withdrawal(address indexed to, uint256 amount, uint256 timestamp);
    
    // Emitted when funds are deposited to the wallet
    event Deposit(address indexed from, uint256 amount, uint256 timestamp);

    /**
     * @notice Initializes the wallet with the deployer as administrator
     * @dev Sets msg.sender as the wallet administrator during deployment
     */
    constructor() {
        administrator = payable(msg.sender);
    }
    
    /**
     * @notice Allows the contract to receive ETH
     * @dev This function is automatically called when ETH is sent to the contract
     */
    receive() external payable {
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }
    
    /**
     * @notice Retrieves the current ETH balance of this wallet
     * @dev Uses the built-in balance property of the contract's address
     * @return Current balance in wei
     */
    function checkBalance() external view returns (uint256) {
        return address(this).balance;
    }
    
    /**
     * @notice Allows the administrator to withdraw a specific amount
     * @dev Transfers the requested amount to the administrator
     * @param amount The amount of wei to withdraw
     */
    function withdrawFunds(uint256 amount) external {
        // Verify caller is the administrator
        require(msg.sender == administrator, "Access denied: administrator only");
        
        // Transfer the funds to the administrator
        administrator.transfer(amount);
        
        // Log the withdrawal
        emit Withdrawal(msg.sender, amount, block.timestamp);
    }
}
