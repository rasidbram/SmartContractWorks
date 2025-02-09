// // SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract SampleConractPayable {
    string public myString = "helloo";

    function updateString(string memory _newString) public payable {
        // public: Anyone can call this function.
        // ❗️❗️❗️ payable: This function can receive Ether along with the transaction.
        // _newString: A string parameter that will be stored in myString.

        if (msg.value == 1 ether) {
            myString = _newString;
        } else {
            payable(msg.sender).transfer(msg.value);
        }
        // msg.value: Represents the amount of Ether (in Wei) sent with the transaction.
        // Check: If msg.value == 1 ether (i.e., exactly 1 Ether is sent), the contract updates myString with _newString.
        // Else Condition: If the sender does not send exactly 1 Ether, the contract:
        // ❗️❗️❗️ Refunds the sender by returning their Ether (msg.value).
        // payable(msg.sender).transfer(msg.value); ensures the refund.
        // ✅ Use Case: Ensures users must send exactly 1 Ether to update myString, preventing accidental updates or incorrect amounts.
    }
}
