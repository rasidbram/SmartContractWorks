// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleExceptionRequire {
    mapping(address => uint256) public balanceReceived;

    // A mapping that stores the balance of each address.
    // Key: address (user's Ethereum wallet)
    // Value: uint256 (balance in wei)
    // The public keyword allows external contracts or users to read balances.

    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
        // Increases the sender's (msg.sender) balance by the amount sent (msg.value).
        // msg.value contains the amount of ETH (in wei) received.
    }

    function withdrawMoney(address payable _to, uint256 _amount) public {
        // _to: The address where the ETH will be sent.
        // _amount: The amount to withdraw.

        require(_amount > 0, "Withdrawal amount must be greater than zero");
        require(balanceReceived[msg.sender] >= _amount, "Insufficient balance");
        // If the user tries to withdraw more than their balance, the transaction reverts.

        balanceReceived[msg.sender] -= _amount;
        // **First update the balance (prevents reentrancy attack)**

        _to.transfer(_amount);
        // Limits gas to 2,300 (safe against reentrancy attacks).
        // Reverts if the transfer fails.
    }
}
