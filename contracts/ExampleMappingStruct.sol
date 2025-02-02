// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract MappingStructExample {
    struct Transaction {
        uint256 amount;
        uint256 timestamp;
    }

    // Defines a struct called Transaction.
    // amount: Stores the transaction amount (uint256 type).
    // timestamp: Stores the transaction timestamp (will be set using block.timestamp).
    // Purpose: To store deposit and withdrawal transactions with their respective amounts and timestamps.

    struct Balance {
        uint256 totalBalance;
        uint256 numDeposits;
        mapping(uint256 => Transaction) deposits;
        uint256 numWithdrawals;
        mapping(uint256 => Transaction) withdrawals;
    }

    // This Balance structure keeps track of a user's financial status:

    // totalBalance: Stores the user’s total balance.
    // numDeposits: Stores the number of times the user has deposited funds.
    // deposits: A mapping that stores all deposit transactions using a unique index (numDeposits).
    // The mapping(uint256 => Transaction) allows each deposit transaction to be recorded sequentially with an index.
    // numWithdrawals: Stores the number of times the user has withdrawn funds.
    // withdrawals: A mapping that stores withdrawal transactions with an index.

    mapping(address => Balance) public balances;

    // balances: A mapping that stores each user's (address) financial information (Balance struct).
    // Purpose:
    // Keeps track of a user’s total balance, deposit, and withdrawal transactions.
    // Accessing balances[msg.sender].totalBalance will return a user’s total ETH balance.

    function getDepositNum(address _from, uint256 _numDeposit)
        public
        view
        returns (Transaction memory)
    {
        return balances[_from].deposits[_numDeposit];
    }

    // Retrieves a specific deposit transaction (_numDeposit) of a given user (_from).
    // view: This function only reads data and does not modify blockchain state.
    // returns (Transaction memory):
    // Returns a Transaction struct, containing the deposit amount and timestamp.
    // Example Usage:
    // getDepositNum(0x123..., 2);
    // Output: Returns the third deposit transaction (index starts from 0).

    function depositMoney() public payable {
        // This function allows users to deposit ETH.
        // payable: Allows the function to receive ETH.

        balances[msg.sender].totalBalance += msg.value;
        // Increases the sender’s (msg.sender) balance by the deposited ETH amount (msg.value).

        Transaction memory deposit = Transaction(msg.value, block.timestamp);
        // Creates a new Transaction object with:
        // amount: The deposited ETH amount.
        // timestamp: The current time (block.timestamp).

        balances[msg.sender].deposits[
            balances[msg.sender].numDeposits
        ] = deposit;
        // Stores the deposit transaction in the deposits mapping.
        // Uses numDeposits as an index to store each deposit sequentially.

        balances[msg.sender].numDeposits++;
        // Increments the deposit count by 1.
    }

    function withdrawMoney(address payable _to, uint256 _amount) public {
        // Purpose: Allows a user to withdraw _amount ETH to a specified address _to.
        // _to: The destination wallet address for the withdrawal.
        // _amount: The amount of ETH the user wants to withdraw.
        // payable: Required to send ETH to another address.

        balances[msg.sender].totalBalance -= _amount;
        // Decreases the sender’s total balance by _amount.

        Transaction memory withdrawal = Transaction(_amount, block.timestamp);
        // Creates a new withdrawal transaction with:
        // amount: The amount being withdrawn.
        // timestamp: The withdrawal timestamp.

        balances[msg.sender].withdrawals[
            balances[msg.sender].numWithdrawals
        ] = withdrawal;
        // Stores the withdrawal transaction in the withdrawals mapping.
        // Uses numWithdrawals as an index to store each withdrawal sequentially.

        balances[msg.sender].numWithdrawals++;
        // Increments the withdrawal count by 1.
        
        balances[msg.sender].numWithdrawals;
        // Assigns a new numWithdrawals value to the user’s structure.

        _to.transfer(_amount);
        // Withdraws _amount ETH to the specified address (_to).
        // Executes the ETH transfer on the blockchain. 
    }
}
