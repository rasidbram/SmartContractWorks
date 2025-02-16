// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ContractOne {
    mapping(address => uint256) public addressBalances;

    // A mapping that stores the balance of each address.
    // The balances are updated using addressBalances[msg.sender].

    function deposit() public payable {
        addressBalances[msg.sender] += msg.value;
    }

    receive() external payable {
        deposit();
    }
    // The receive function calls the deposit() function when Ether is sent directly to the contract.
}

contract ContractTwo {
    receive() external payable {}

    // This function executes when Ether is sent to ContractTwo, but it does not store the Ether in any variable.

    function depositOnContractOne(address _contractOne) public {
        // bytes memory payload = abi.encodeWithSignature("deposit()");
        (bool success, ) = _contractOne.call{value: 10, gas: 100000}("");
        require(success);
    }
    // Attempts to send 10 wei to ContractOne at the _contractOne address.
    // Sends 10 wei and 100,000 gas using the call method.
    // However, the deposit() function is not being called because the call is made with an empty string ("").
    // The success variable checks if the operation was successful, and if not, require(success); reverts the transaction.
}
