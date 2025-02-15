// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract MyContract {
    uint256 public myUint = 123;

    function setMyUint(uint256 _myUint) public {
        myUint = _myUint;
    }
}
