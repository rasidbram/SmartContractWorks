// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract WillThrow {
    error NotAllowedError(string);

    // In Solidity 0.8, the error keyword is used to define a custom error.
    // This consumes less gas compared to returning an error message inside require or revert.
    // It takes a parameter of type string, meaning it can include an error message.

    function aFunction() public pure {
        // public – This function can be called both inside the contract and externally.
        // pure – The function does not modify or read the blockchain state (it does not change variables or interact with storage).

        // ------require(false, "error mesage");

        // The require function checks whether the given condition is true.
        // If the condition is false, the transaction fails and reverts with the error message "error message".
        // Since false is always false, this function will always fail and revert when called.
        // require consumes gas up to the point of failure but refunds unused gas.
        // The string "error message" increases gas consumption.

        // ------assert(false);

        // The assert function is always used to detect critical logic errors.
        // assert(false); will always fail and consume all gas.
        // When assert fails, the transaction is reverted with a "Panic(uint256)" error.

        // require is typically used for input validation and refunds some gas when it fails.
        // assert is used for detecting logical errors, and when it fails, all gas is consumed.
        // assert should only be used to check for conditions that should never occur.

        revert NotAllowedError("You are not allowed");
        // This function always throws a NotAllowedError error when executed.
        // The error message returned is "You are not allowed".
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);
    event ErrorLogCode(uint256 code);
    event ErrorLogBytes(bytes lowLevelData);

    // Events are used in Ethereum to log errors so they can be tracked on the blockchain.
    // ErrorLogging(string reason): Logs errors thrown using require or revert with a message.
    // ErrorLogCode(uint256 code): Logs errors triggered by assert and similar situations.
    // ErrorLogBytes(bytes lowLevelData): Logs raw error data for unexpected failures.

    function catchTheError() public {
        WillThrow will = new WillThrow();
        // Creates a new instance of WillThrow.

        try will.aFunction() {
            // add code if it works
        } catch Error(string memory reason) {
            // Executes if the error is a revert with a message (string).
            // Example: revert("An error occurred") will trigger this block.
            // Emits the ErrorLogging(reason) event with the error message.
            emit ErrorLogging(reason);
        } catch Panic(uint256 errorCode) {
            // Executes for critical errors like assert(false); or arithmetic overflows.
            // Solidity assigns Panic(uint256) error codes
            emit ErrorLogCode(errorCode);
        } catch (bytes memory lowLevelData) {
            // Executes if the error does not match Error or Panic.
            // Example: If an assembly operation fails.
            // Emits the ErrorLogBytes(lowLevelData) event with the raw error data.
            emit ErrorLogBytes(lowLevelData);
        }
    }
}

            // 🟢 Summary
            // ✅ Demonstrates how to use try-catch for error handling.
            // ✅ Uses custom error definitions to save gas.
            // ✅ Handles different error types (Error, Panic, lowLevelData).
            // ✅ Ensures smart contracts are more secure by managing errors properly.
