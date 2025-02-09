// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

//This Solidity smart contract, TheBlockchainMessenger, demonstrates ownership control, state variables, and message updates with a counter.

contract TheBlockchainMessenger {
    uint256 public changeCounter;
    // changeCounter: A public unsigned integer that keeps track of how many times the message has been updated.

    address public owner;
    // owner: Stores the Ethereum address of the contract deployer.

    string public theMessage;

    //  A public string that holds a message.

    constructor() {
        owner = msg.sender;
    }

    // ❗️❗️❗️ The constructor runs only once when the contract is deployed.
    // It assigns owner = msg.sender, meaning the deployer of the contract becomes the owner.
    // This ensures that only the deployer can update the message.

    function updateTheMessage(string memory _newMessage) public {
        if (msg.sender == owner) {
            theMessage = _newMessage;
            changeCounter++;
        }
    }

    // This function modifies the state by updating theMessage and incrementing changeCounter.
    // The function checks if msg.sender is the owner:
    // ✅ If yes, the message is updated, and changeCounter increments.
    // ❌ If no, nothing happens (non-owners cannot update the message).
    // Since it modifies the blockchain state, it requires a transaction and incurs gas fees.
}

// Summary
// 📌 What this contract does:
// ✅ Assigns the deployer as the owner.
// ✅ Allows only the owner to update the message.
// ✅ Keeps track of how many times the message is changed.

// 📌 Key Points:

// msg.sender captures the caller’s Ethereum address.
// Constructor runs only once to set the owner.
// Non-owners cannot modify theMessage.
// State-modifying functions require gas.
// This contract is useful for creating an on-chain message board with restricted editing rights.
