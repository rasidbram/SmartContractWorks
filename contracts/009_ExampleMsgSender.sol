// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleMsgSender {
    address public someAddress;

    // someAddress: A state variable of type address.
    // Since it is marked as public, Solidity automatically generates a getter function, allowing external access.
    // Initially, it is uninitialized (defaults to 0x0000000000000000000000000000000000000000).

    function updateSomeAddress() public {
        someAddress = msg.sender;

        // This function updates someAddress with the Ethereum address of the caller.
        // ❗️❗️❗️ msg.sender is a global variable in Solidity that represents the --address of the entity (EOA or contract)-- that called the function.
        // msg.sender keeps current conract address
        // Since this function modifies the state of the contract, it requires a transaction and incurs gas fees.
    }
}

// 📌📌📌 Key Points: 📌📌📌

// msg.sender refers to the caller of the function (EOA or contract).
// The contract keeps track of the last address that interacted with it.
// The function requires a transaction, so gas fees apply.
// ❗️❗️❗️This contract is useful for recording who interacted with it last.
