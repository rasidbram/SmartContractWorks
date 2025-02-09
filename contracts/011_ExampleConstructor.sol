// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleConstructor {
    address public myAddress;

    // myAddress: A state variable of type address.
    // Since it is marked as public, Solidity automatically generates a getter function, allowing external access.
    // Initially, this variable is not assigned a value; it will be set during contract deployment.

    constructor(address _someAddress) {
        myAddress = _someAddress;
    }

    // ❗️❗️❗️A constructor is a special function that runs ❗️❗️❗️only once when the contract is deployed.
    // _someAddress is passed as a parameter during deployment and assigned to myAddress.
    // This ensures myAddress has a predefined value when the contract is created.
    // When deploying the contract, the deployer can set an initial address.

    function setMyAddress(address _myAddress) public {
        myAddress = _myAddress;

        //This function allows anyone to update the myAddress variable by passing a new Ethereum address (_myAddress).
        //Since it modifies the state, it requires a transaction and incurs gas fees.
    }

    function setMyAddressToMsgSender() public {
        myAddress = msg.sender;
        // This function updates myAddress to the caller’s address (msg.sender).
        // msg.sender is the Ethereum address that called the function.
        // It also requires a transaction and incurs gas fees.
        // A user can register their own address without passing it as a parameter.
    }
}
