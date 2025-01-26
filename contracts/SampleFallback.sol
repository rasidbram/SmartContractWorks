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
