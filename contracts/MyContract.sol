// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;


contract MyContract {

    string public ourString = "Hello world!";

    function updateOurString(string memory _updateString) public {
        ourString = _updateString;
    }

}