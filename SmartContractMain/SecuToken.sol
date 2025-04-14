// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Secutoken is ERC20, AccessControl {
    bytes32 public constant TREASURER_ROLE = keccak256("TREASURER_ROLE");

    constructor() ERC20("Secutoken", "SKTN") {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());

        // Give deployer both admin and treasurer roles
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
}
