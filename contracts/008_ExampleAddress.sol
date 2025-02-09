// // SPDX-License-Identifier: MIT

pragma solidity 0.8.28; // required to use Solidity 0.8 syntax

contract ExampleAddress {
    address public someAddress;

    // an instance variable of type address.

    function setSomeAddress(address _someAddress) public {
        someAddress = _someAddress;
        // set a new value for someAddress.
        // Since it modifies the state, calling this function requires a transaction and incurs gas fees.
    }

    function getAddressBalance() public view returns (uint256) {
        return address(someAddress).balance;
        // address(someAddress).balance retrieves the current ETH balance of that address.
        // The function is marked as view, meaning it does not modify the blockchain and therefore does not require gas.
    }
}
