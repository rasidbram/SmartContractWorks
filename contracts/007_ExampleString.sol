// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract ExampleString {
    string public myString = "Hello World";
    // myString: A string variable initialized with "Hello World".
    // Since it is marked as public, Solidity automatically generates a getter function, allowing external access to its value.

    bytes public myBytes = "Hello World";

    // myBytes: A variable that stores the same "Hello World" value but as a bytes type like 0x8723y8hjjbxbxsub
    // The bytes array is similar to string, but it is a lower-level data structure.

    // ---Key Difference:
    // string and bytes are similar but have differences:

    // string is a sequence of characters and can be used directly. "hello"
    // bytes is a raw byte array and can be more efficient for storage and processing. "0xbasxbxn"

    function setMyString(string memory _myString) public {
        myString = _myString;
        // memory: Indicates that _myString will be temporarily stored in memory during the function execution.
        // public: Allows anyone to call this function.
        // Since this function modifies the state, it requires a transaction and incurs a gas fee.
    }

    function compareTwoStrings(string memory _myString)
        public
        view
        returns (bool)
    {
        return
            keccak256(abi.encode(myString)) == keccak256(abi.encode(_myString));
    }
    // ---How Does It Work?
    // keccak256(abi.encode(myString)):

    // Converts myString into bytes using abi.encode.
    // Then, it generates a hash using keccak256 (Ethereum’s version of SHA-3).
}

// 📌📌📌 Key Points: 📌📌📌

// string and bytes are similar, but bytes is more optimized in some cases.
// ❗️❗️❗️Solidity does not support direct string comparisons, so we use keccak256.
// view functions do not modify the blockchain state, meaning they do not require gas.
