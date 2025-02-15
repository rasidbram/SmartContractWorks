// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract EventExample {
    mapping(address => uint256) public tokenBalance;
    // A mapping that keeps track of each address’s token balance.

    event TokensSent(address _from, address _to, uint256 _amount);

    //Events are not stored in contract storage, making them gas-efficient.
    // Defines an event named TokensSent to log token transfers.

    constructor() {
        tokenBalance[msg.sender] = 100;

        // Runs only once when the contract is deployed.
        // Assigns 100 tokens to the deployer's (msg.sender) balance.
    }

    function sendToken(address _to, uint256 _amount) public returns (bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens!");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        emit TokensSent(msg.sender, _to, _amount);

        return true;
    }
}

// Why Use Events?
// ✅ Efficient Logging – Events store data in transaction logs (cheaper than storing in contract state).
// ✅ Off-Chain Tracking – Web3.js or other dApps can listen for these events to track token transfers.
// ✅ Easier Debugging – Helps developers track contract interactions.
