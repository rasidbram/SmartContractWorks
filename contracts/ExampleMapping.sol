// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleMapping {
    mapping(uint256 => bool) public myMapping; // mapping to boolean
    mapping(address => bool) public myAddressMapping; // mapping to bool (no need for mapping if we store addresses in the same mapping type as the key)
    mapping(uint256 => mapping(uint256 => bool)) public uintUintBoolMapping;

    function setValue(uint256 _index) public {
        myMapping[_index] = true; // set value to boolean
    }

    // function setMyAddressToTrue(address _myAddress) public {
    //     myAddressMapping[_myAddress] = true;
    // }
    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true; // set address to boolean
    }

    function setUintUintBoolMapping(
        uint256 _index1,
        uint256 _index2,
        bool _value
    ) public {
        uintUintBoolMapping[_index1][_index2] = _value; // sets a boolean to the given index for each value in the mapping type. If you only store addresses as keys this will work. 
    }
}
