// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import "./029_Ownable.sol";

contract InheritanceModifierExample is Owner {
    // This contract inherits from another contract named Owner.
    // The Owner contract likely contains an owner state variable and an onlyOwner modifier to restrict certain functions.

    mapping(address => uint256) public tokenBalance;
    uint256 tokenPrice = 1 ether;

    // tokenBalance: A mapping that tracks how many tokens each address holds.
    // tokenPrice: The cost of one token in Ether (1 ETH per token).

    constructor() {
        tokenBalance[msg.sender] = 100;
    }

    // The constructor is executed once when the contract is deployed.
    // It assigns 100 tokens to the deployer of the contract (msg.sender).

    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    // This function mints new tokens but is restricted to the contract's owner using the onlyOwner modifier.

    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }

    // The owner can reduce the token supply by burning their tokens.

    function purchaseToken() public payable {
        require(
            (tokenBalance[owner] * tokenPrice) / msg.value > 0,
            "not enough tokens"
        );
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    // Allows users to buy tokens by sending ETH (msg.value).

    function sendToken(address _to, uint256 _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }

    // Allows users to transfer tokens to another address.
}
