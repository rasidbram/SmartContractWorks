// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract MyContract {
    string public ourString = "Hello world!";

    // ourString → A public string variable initialized with "Hello world!".
    // public → Creates an automatic getter function, allowing external users or contracts to read the string.

    function updateOurString(string memory _updateString) public {
        ourString = _updateString; // setter methodto the `ourString` property(variable) with a passed argument
    }

    // Takes _updateString (a new string) as input.
    // Updates ourString with the new value.
    // Uses memory because Solidity requires specifying data location (memory for temporary storage, storage for permanent contract storage).
}
