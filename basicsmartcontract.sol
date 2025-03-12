// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleStorage
 * @author Danushka Fonseka
 * @notice This contract demonstrates basic functionality of storing and retrieving a number.
 * It includes detailed comments to help those unfamiliar with Solidity understand each part.
 */
contract SimpleStorage {
    // @dev This is a private variable that stores a single unsigned integer.
    // It's only accessible within this contract.
    uint private storedNumber;

    /**
     * @dev Stores a number in the contract's storage.
     * @param num The number to store (must be 0 or higher)
     */
    function setNumber(uint num) public {
        // The "storedNumber" variable is updated to the provided value
        storedNumber = num;
    }

    /**
     * @dev Retrieves the currently stored number.
     * @return The stored number as an unsigned integer
     */
    function getNumber() public view returns (uint) {
        // "view" means this function doesn't modify contract state
        return storedNumber;
    }

    // ======== COMMENTED EXPLANATION OF KEY CONCEPTS ========

    // **Contract Structure**
    // - "contract" keyword defines a new smart contract
    // - All functions and variables are contained within curly braces {}

    // **Variables**
    // - "uint" is an unsigned integer (can't be negative)
    // - "private" means only this contract can access this variable directly

    // **Functions**
    // - "public" automatically creates a getter function for state variables
    // - "view" specifies this function doesn't modify contract state
    // - "returns (uint)" defines the data type returned by the function

    // **Special Comments**
    // - "@notice" provides a human-readable description for contract users
    // - "@dev" explains technical details for developers
    // - "@param" describes input parameters
    // - "@return" explains output values

    // **Deployment & Interaction**
    // 1. Compile with solc (Solidity compiler)
    // 2. Deploy to Ethereum network using tools like Remix or Hardhat
    // 3. Interact via Ethereum wallet or web3 library
    */
}
