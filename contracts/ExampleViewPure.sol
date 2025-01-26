// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleViewPure {
    uint256 public myStorageVariable;

    function getMyStorageVariable() public view returns (uint256) {
        return myStorageVariable;
    }

    function getAddition(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function setMyStorageVariable(uint _newVar) public returns (uint){
        myStorageVariable = _newVar;
        return _newVar;
    }
}
