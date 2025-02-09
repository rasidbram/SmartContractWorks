// // SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleBoolean {
    bool public myBool; // default myBool is false

    function setMyBool(bool _myBool) public{
        myBool = _myBool; // set to true
    }
}