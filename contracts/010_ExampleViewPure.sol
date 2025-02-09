// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleViewPure {
    uint256 public myStorageVariable;

    // myStorageVariable: A state variable of type uint256 (unsigned integer).
    // Since it is marked as public, Solidity automatically generates a getter function, allowing external access.
    // By default, this variable is initialized to 0.

    function getMyStorageVariable() public view returns (uint256) {
        return myStorageVariable;
        // This function retrieves the value of myStorageVariable.
        // It is marked as view, meaning it reads blockchain state but does not modify it.
        // ❗️❗️❗️Since it does not change the blockchain, calling it externally (e.g., from a frontend) does not require gas.
    }

    function getAddition(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
        // This function takes two numbers (a and b), adds them, and returns the result.
        // It is marked as pure, meaning it does not read or modify any state variables.
        // ❗️❗️❗️Since it only performs a calculation, calling it externally does not require gas.
        // Used for mathematical operations that do not interact with blockchain data.
    }

    function setMyStorageVariable(uint256 _newVar) public returns (uint256) {
        myStorageVariable = _newVar;
        return _newVar;

        // This function modifies the state variable myStorageVariable by setting it to _newVar.
        // ❗️❗️❗️ Since it changes the blockchain state, it requires a transaction and incurs gas fees.
        // The function returns the newly stored value.
    }
}

// 📌📌📌 Key Points: 📌📌📌

// view functions only read blockchain data and do not require gas.
// pure functions do not read or modify blockchain data and do not require gas.
// State-modifying functions change the blockchain state and require gas.
// This contract provides a clear example of how to handle state variables, calculations, and blockchain interactions efficiently. 🚀
