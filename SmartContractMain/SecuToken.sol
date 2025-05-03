// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract SecuToken is ERC20, AccessControl, Pausable {
    bytes32 public constant TREASURER_ROLE = keccak256("TREASURER_ROLE");

    // Severity Enum
    enum Severity { Low, Medium, High, Critical }

    // Severity levels mapped to payout amounts
    mapping(Severity => uint256) public severityRewardMap;

    // Events for transparency
    event SeverityRewardUpdated(Severity severity, uint256 rewardAmount);
    event RewardIssued(address indexed user, Severity severity, uint256 amount);
    event RewardIssuedBulk(address indexed user, uint256 totalAmount);
    event DepositedToContract(address indexed from, uint256 amount);

    constructor() ERC20("SecuToken", "SKTN") {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(TREASURER_ROLE, msg.sender);
    }

    // Admin functions to pause/unpause contract
    function pause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _unpause();
    }

    // Deposit tokens to the contract
    function depositToContract(uint256 amount) external whenNotPaused {
        _transfer(msg.sender, address(this), amount);
        emit DepositedToContract(msg.sender, amount);
    }

    // Function for TREASURER to send tokens from the contract
    function sendSKTN(address to, uint256 amount) external onlyRole(TREASURER_ROLE) whenNotPaused {
        require(balanceOf(address(this)) >= amount, "Not enough SKTN in contract");
        _transfer(address(this), to, amount);
    }

    // Admin sets payout amount for each CVE severity
    function setSeverityReward(Severity severity, uint256 rewardAmount) external onlyRole(DEFAULT_ADMIN_ROLE) {
        severityRewardMap[severity] = rewardAmount;
        emit SeverityRewardUpdated(severity, rewardAmount);
    }

    // Treasurer rewards user based on severity level
    function rewardUserBySeverity(address user, Severity severity) external onlyRole(TREASURER_ROLE) whenNotPaused {
        uint256 rewardAmount = severityRewardMap[severity];
        require(rewardAmount > 0, "Reward for this severity is not set");
        require(balanceOf(address(this)) >= rewardAmount, "Not enough SKTN in contract");

        _transfer(address(this), user, rewardAmount);
        emit RewardIssued(user, severity, rewardAmount);
    }

    // Treasurer rewards user for multiple severities in one call
    function rewardUserBulk(address user, Severity[] calldata severities) external onlyRole(TREASURER_ROLE) whenNotPaused {
        uint256 totalReward = 0;

        for (uint i = 0; i < severities.length; i++) {
            uint256 reward = severityRewardMap[severities[i]];
            require(reward > 0, "One or more severity rewards not set");
            totalReward += reward;
        }

        require(balanceOf(address(this)) >= totalReward, "Not enough SKTN in contract");
        _transfer(address(this), user, totalReward);
        emit RewardIssuedBulk(user, totalReward);
    }
}
