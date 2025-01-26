// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleConstructor {
    address public myAddress; // public variable

    constructor(address _someAddress) { 
        myAddress = _someAddress; // assign the contract address to myAddress
    }

    function setMyAddress(address _myAddress) public {
        myAddress = _myAddress; // 
    }

     function setMyAddressToMsgSender() public {
        myAddress = msg.sender; 
    }

}
