// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract SampleFallback {
    uint256 public lastValueSent;
    string public lastFunctionCalled;
    uint256 public myUint;

    function setMyUint(uint256 _myUint) public {
        myUint = _myUint;
    }

    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }

    fallback() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }
}

// ❗️❗️❗️  in order for a smart contract to receive ETH transfers, it must implement either the ❗️receive() or ❗️fallback() function.

// ❗️❗️❗️When does each function trigger?
// receive() → Triggers when the contract receives ETH with ❗️no data.
// fallback() → Triggers when: ETH is sent with ❗️unknown function data.

// ❗️❗️❗️ Is this considered Low-Level Interaction?
// Yes, sending ETH to a contract using call, send, or transfer is considered a low-level interaction because:
// It interacts with the contract at the bytecode level without calling a predefined function explicitly.
// Functions like receive() and fallback() handle raw ETH transactions without structured function calls.
