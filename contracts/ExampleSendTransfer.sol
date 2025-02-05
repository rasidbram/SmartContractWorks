// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract Sender {
    receive() external payable {}

    // This is known as a fallback function.
    // It executes when the contract receives Ether through an external transaction (msg.value).
    // Since this function is empty, it simply accepts the incoming Ether without performing any additional operations.

    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }

    // This line sends 10 wei to the _to address using the transfer function.
    // The transfer function automatically reverts the transaction if it fails.

    function withdrawSend(address payable _to) public {
        bool isSent = _to.send(10);

        require(isSent, "Unsuccessful!");
    }
    // This function sends 10 wei using the send function.
    // Unlike transfer, send does not automatically revert if the transaction fails; instead, it returns true or false.
    // The require(isSent, "Unsuccessful!"); statement ensures that if the transfer fails, the transaction is reverted.
}

// ---Key Points:

// -transfer:
// Imposes a 2300 gas limit.
// If the transfer fails, it automatically reverts.

// -send:
// Also imposes a 2300 gas limit.
// If the transfer fails, it only returns false instead of reverting.
// If the recipient contract performs additional operations in its receive or fallback function (e.g., emitting an event), the 2300 gas limit may not be enough, causing the send function to fail.

// ------------------------------------------------------------------------------------------------------------

contract ReceiverNoAction {
    // This contract is a simple contract designed solely to receive Ether.
    function balance() public view returns (uint256) {
        // This function returns the current balance of the contract.
        return address(this).balance;
    }

    receive() external payable {}
    // This function automatically accepts incoming Ether from the Sender contract or any other account.
    // Since it performs no additional operations, it can receive Ether sent via both the transfer and send functions without issues.
}

// ---Key Points
// When Ether is sent to this contract using transfer or send, there are no issues, because the receive function does not execute additional logic.
// The 2300 gas limit imposed by transfer and send is sufficient for the transaction to succeed.

// ------------------------------------------------------------------------------------------------------------

contract ReceiverAction {
    // This contract also accepts Ether but performs an additional operation to record the received amount.
    uint256 public balanceRecived;

    // A variable used to store the amount of received Ether.

    receive() external payable {
        balanceRecived += msg.value;
    }

    // Executes when the contract receives Ether.
    // Uses balanceReceived += msg.value; to record the received amount.
    // Since this modifies storage, it requires additional gas and may exceed the 2300 gas limit imposed by transfer and send.

    function balance() public view returns (uint256) {
        return address(this).balance;
    }
    // Returns the contract's current balance.
}

// Key Points
// If Ether is sent to this contract using Sender.withdrawSend(), the transaction will likely fail because the 2300 gas limit from send may not be enough to update storage (balanceReceived += msg.value;).
// If Sender.withdrawTransfer() is used, it will revert since transfer also enforces the 2300 gas limit.

// ------------------------------------------------------------------------------------------------------------

// Conclusion
// If you are making a payment to a contract like ReceiverAction, do not use transfer or send. Instead, use the low-level call function:

// (bool success, ) = _to.call{value: 10}("");
// require(success, "Failed to send Ether");

// If you are sending Ether to a contract that only accepts payments (like ReceiverNoAction), you can use transfer or send.
// transfer is safer because it automatically reverts if an error occurs.
// send returns false on failure but does not revert automatically, so if you don’t check the return value, you might not notice the failure.
