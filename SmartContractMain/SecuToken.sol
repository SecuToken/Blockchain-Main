// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract SecuToken is ERC20, AccessControl {
    bytes32 public constant TREASURER_ROLE = keccak256("TREASURER_ROLE");

    // Severity levels mapped to payout amounts
    mapping(uint8 => uint256) public severityRewardMap;

    // Events for transparency
    event SeverityRewardUpdated(uint8 severity, uint256 rewardAmount);
    event RewardIssued(address indexed user, uint8 severity, uint256 amount);

    constructor() ERC20("SecuToken", "SKTN") {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(TREASURER_ROLE, msg.sender);
    }

    // Function for TREASURER to send tokens from the contract
    function sendSKTN(address to, uint256 amount) external onlyRole(TREASURER_ROLE) {
        require(balanceOf(address(this)) >= amount, "Not enough SKTN in contract");
        _transfer(address(this), to, amount);
    }

    // Deposit tokens to the contract
    function depositToContract(uint256 amount) external {
        _transfer(msg.sender, address(this), amount);
    }

    // Admin sets payout amount for each CVE severity
    function setSeverityReward(uint8 severity, uint256 rewardAmount) external onlyRole(DEFAULT_ADMIN_ROLE) {
        severityRewardMap[severity] = rewardAmount;
        emit SeverityRewardUpdated(severity, rewardAmount);
    }

    // Treasurer rewards user based on severity level
    function rewardUserBySeverity(address user, uint8 severity) external onlyRole(TREASURER_ROLE) {
        uint256 rewardAmount = severityRewardMap[severity];
        require(rewardAmount > 0, "Invalid severity level or reward not set");
        require(balanceOf(address(this)) >= rewardAmount, "Not enough SKTN in contract");

        _transfer(address(this), user, rewardAmount);
        emit RewardIssued(user, severity, rewardAmount);
    }
}
