// // SPDX-License-Identifier: MIT

pragma solidity 0.8.28;  // required to use Solidity 0.8 syntax

contract ExampleAddress {
    address public someAddress; // an instance variable of type address.

    function setSomeAddress(address _someAddress) public {
        someAddress = _someAddress; // set a new value for someAddress.
    }

    function getAddressBalance() public view returns (uint256) {
        return address(someAddress).balance; // get the balance of the contract instance at someAddress.
    }
}
