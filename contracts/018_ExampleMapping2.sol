// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleMappingWithdrawls {
    mapping(address => uint256) public balanceReceived;

    // balanceReceived: This keeps track of how much ETH each address (user) has sent to the contract.
    // The mapping creates a relationship between an address (key) and the amount of ETH sent (value)
    // Since it is marked as public, anyone can view this data.

    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    // Allows users to send ETH to the contract.
    // msg.sender: Refers to the address of the user who called the function.
    // msg.value: Refers to the amount of ETH sent with the transaction.
    // Every time a user sends ETH, the amount is added to their balance in the balanceReceived mapping.

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Returns the total ETH balance held by the contract.
    // address(this).balance: Refers to the total ETH balance of the contract's address.
    // view: Indicates that this function only reads data without modifying the contract state.

    function withdrawAllMoney(address payable _to) public {
        uint256 balanceToSendOut = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSendOut);
    }

    // Allows a user to withdraw all the ETH they have sent to the contract.
    // Parameter:
    // -- _to: The address where the user wants their ETH sent.
    // -- payable: Indicates that this address can receive ETH.
    // Steps:
    // The user’s current balance is retrieved from balanceReceived[msg.sender].
    // The user’s balance is set to 0 (to prevent reentrancy attacks, the balance is reset before transferring funds).
    // The balance is sent to the provided _to address using the transfer function.
}
