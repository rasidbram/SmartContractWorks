// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract Owner {
    address owner;

    constructor() {
        owner = msg.sender;
        // Owner created
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }
}
