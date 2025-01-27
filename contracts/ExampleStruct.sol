// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

// this is an example for Child Smart Contract!!!!
contract Wallet {
    PaymentReceived public payment;

    function payContract() public payable {
        payment = new PaymentReceived(msg.sender, msg.value); // this is subcontract
    }
}

contract PaymentReceived {
    address public from;
    uint256 public amount;

    constructor(address _from, uint256 _amount) {
        from = _from;
        amount = _amount;
    }
}

// Payment Process
// The user calls the payContract function of the Wallet contract and sends Ether.
// The payContract function creates a new PaymentReceived contract and:
// Uses msg.sender (the address of the sender) and
// msg.value (the amount of Ether sent) to store payment details.
// The PaymentReceived contract stores the payment details (from and amount).
// These details can be accessed from the payment variable in the Wallet contract.

// better way Using Structs!!!!
contract Wallet2 {
    struct PaymentRecivedStruct {
        address from;
        uint256 amount;
    }

    PaymentRecivedStruct public payment;

    function payContract() public payable {
        payment = PaymentRecivedStruct(msg.sender, msg.value);

        // payment.from = msg.sender;
        // payment.amount = msg.value;
    }
}


// Which is Better?
// Wallet2 is far more gas-efficient than Wallet1 for tracking payments because:
// It avoids the overhead of deploying a new contract for each payment.
// It uses the existing contract's storage to hold the payment details, minimizing gas costs.
// It is more scalable, as storing data in a struct is much cheaper and sustainable for multiple payments.
