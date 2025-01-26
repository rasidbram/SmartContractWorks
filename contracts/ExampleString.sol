// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleString {
    string public myString = "Hello World";
    bytes public myBytes = "Hello World";

    function setMyString(string memory _myString) public {
        myString = _myString;
    }

    function compareTwoStrings(string memory _myString)
        public
        view
        returns (bool)
    {
        return keccak256(abi.encode(myString)) == keccak256(abi.encode(_myString));
    }
}
