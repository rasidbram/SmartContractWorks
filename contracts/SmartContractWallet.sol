// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract Consumer {
    function getBalance() public view returns (uint256) {
        // This function returns the current balance of the contract.
        // Since it is `view`, it only reads data and does not modify the blockchain state.
        return address(this).balance;
        // Returns the Ethereum balance of the contract
    }

    function deposit() public payable {}
    // This function allows deposits into the contract.
    // The `payable` keyword allows ETH to be sent to the contract.
}

contract SmartContractWallet {
    address payable public owner;
    // The owner of the contract (can send and receive ETH)
    mapping(address => uint256) public allowance;
    // Stores spending limits for specific addresses
    mapping(address => bool) public isAllowedToSend;
    // Determines if an address has permission to send funds

    mapping(address => bool) public guardians;
    // Stores guardian (protector) addresses
    address payable nextowner;
    // The proposed new owner
    mapping(address => mapping(address => bool)) nextOwnerGuardianAssignedBool;
    // Tracks guardian approvals for the new owner
    uint256 quardiansResetCount;
    // Tracks how many guardians have approved the new owner
    uint256 public constant confirmationFromGuardiansForReset = 3;

    // Minimum guardian approvals required for ownership transfer

    constructor() {
        owner = payable(msg.sender);
        // The deployer of the contract becomes the owner
    }

    function setGuardian(address _guardian, bool _isGuardian) public {
        // Function to assign or remove a guardian
        require(msg.sender == owner, "You are not the owner!");
        // Only the current owner can add guardians
        guardians[_guardian] = _isGuardian;
        // Assigns or removes guardian status
    }

    function proposeNewOwner(address payable _newOwner) public {
        // Function to propose a new owner
        require(
            guardians[msg.sender],
            "You are not a guardian of this wallet!"
        ); // Only guardians can propose a new owner
        require(
            nextOwnerGuardianAssignedBool[_newOwner][msg.sender] == false,
            "You are already assigned!"
        ); // The same guardian cannot vote twice

        if (_newOwner != nextowner) {
            nextowner = _newOwner; // Sets the new proposed owner
            quardiansResetCount = 0; // Resets the approval count
        }
        nextOwnerGuardianAssignedBool[_newOwner][msg.sender] = true; // Marks the guardian's approval
        quardiansResetCount++; // Increases the approval count

        if (quardiansResetCount >= confirmationFromGuardiansForReset) {
            owner = nextowner; // Transfers ownership once the required approvals are met
            nextowner = payable(0); // Resets the next owner field
        }
    }

    // Function to set a spending limit for an address
    function setAllowance(address _for, uint256 _amount) public {
        require(msg.sender == owner, "You are not the owner!"); // Only the owner can set allowances
        allowance[_for] = _amount; // Assigns a spending limit to `_for`

        if (_amount > 0) {
            isAllowedToSend[_for] = true; // Grants permission if the limit is greater than 0
        } else {
            isAllowedToSend[_for] = false; // Removes permission if the limit is 0
        }
    }

    // Function to transfer funds
    function transfer(
        address payable _to, // The recipient address
        uint256 _amount, // The amount of ETH to send
        bytes memory _payload // Additional data for function calls (if needed)
    ) public returns (bytes memory) {
        if (msg.sender != owner) {
            // If the sender is not the owner, additional checks apply
            require(
                isAllowedToSend[msg.sender],
                "You are not allowed to send anything from this smart contract!"
            ); // Ensures the sender has permission
            require(
                allowance[msg.sender] >= _amount,
                "You are trying to send more money than you are allowed!"
            ); // Ensures the sender does not exceed their limit

            allowance[msg.sender] -= _amount; // Deducts the amount from the sender's allowance
        }

        (bool success, bytes memory returnData) = _to.call{value: _amount}(
            _payload
        ); // Executes the ETH transfer

        require(success, "Aborting, call was not successful!"); // Reverts if the transaction fails
        return returnData; // Returns any data from the call (if applicable)
    }

    // Special function that allows the contract to receive ETH
    receive() external payable {}
}
