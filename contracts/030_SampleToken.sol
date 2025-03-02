// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CoffeeToken is ERC20, AccessControl {
    // ERC20: Implements standard ERC-20 token functionality (like minting, transferring, and burning tokens).
    // AccessControl: Allows role-based permissions for actions like minting.

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    // Defines a MINTER_ROLE using keccak256, ensuring a unique hash-based identifier.
    // This role allows certain accounts (like the deployer) to mint new tokens.

    event CoffeePurchased(address indexed receiver, address indexed buyer);

    // This event is emitted when a coffee is purchased.
    // It records both the receiver (who gets the coffee) and the buyer (who paid for it).

    constructor() ERC20("CoffeeToken", "CFE") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        // Initializes the token with the name "CoffeeToken" and symbol "CFE".
        // Grants admin rights (DEFAULT_ADMIN_ROLE) and minting rights (MINTER_ROLE) to msg.sender (the deployer).
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
        // Only accounts with MINTER_ROLE can call this.
        // Mints amount of CoffeeToken to the to address.
    }

    function buyOneCoffee() public {
        _burn(_msgSender(), 1);
        emit CoffeePurchased(_msgSender(), _msgSender());
        // Burns 1 CoffeeToken from the caller (_msgSender()).
        // Emits a CoffeePurchased event, indicating the buyer purchased coffee for themselves.
    }

    function buyOneCoffeeFrom(address account) public {
        _spendAllowance(account, _msgSender(), 1);
        _burn(account, 1);
        emit CoffeePurchased(_msgSender(), account);
        // Allows a user to buy coffee on behalf of another (account).
        // Uses _spendAllowance() to check and reduce the allowance (ensuring the buyer has approval).
        // Burns 1 CoffeeToken from the account.
        // Emits the CoffeePurchased event with the buyer (_msgSender()) and receiver (account).
    }
}

// Summary
// CoffeeToken is an ERC-20 token with access control.
// The MINTER_ROLE can mint tokens.
// Users can burn tokens to "buy coffee."
// It supports self-purchase and buying for others (with approval).
