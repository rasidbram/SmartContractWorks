;(async () => {
    try {
        const address = '0x609025291C9B176C15cEe617C6e75EC5374384Fb' // ✅ Contract Address not account
        const abiArray = [
            {
                inputs: [],
                name: 'myUint',
                outputs: [{internalType: 'uint256', name: '', type: 'uint256'}],
                stateMutability: 'view',
                type: 'function',
            },
            {
                inputs: [
                    {internalType: 'uint256', name: '_myUint', type: 'uint256'},
                ],
                name: 'setMyUint',
                outputs: [],
                stateMutability: 'nonpayable',
                type: 'function',
            },
        ]

        if (typeof web3 === 'undefined') {
            throw new Error(
                'Web3 is not initialized. Make sure MetaMask or a provider is connected.'
            )
        }

        const contractInstance = new web3.eth.Contract(abiArray, address)
        console.log('✅ Contract instance created successfully')

        // Get initial value
        let contractValue = await contractInstance.methods.myUint().call()
        console.log('🔹 Initial contract value:', contractValue)

        // Get accounts
        let accounts = await web3.eth.getAccounts()
        if (!accounts.length) throw new Error('No Ethereum accounts found!')

        // Send transaction
        console.log('🔹 Sending transaction to update myUint...')
        let txResult = await contractInstance.methods
            .setMyUint(112)
            .send({from: accounts[0]}) // ✅ Added gas

        console.log('✅ Transaction result:', txResult)

        // Fetch updated value
        contractValue = await contractInstance.methods.myUint().call()
        console.log('🔹 Updated contract value:', contractValue)
    } catch (error) {
        console.error('❌ Error:', error.message)
    }
})()

// Why Do We Use abiArray in Web3.js?
// The ABI (Application Binary Interface) is needed because smart contracts on Ethereum are compiled into bytecode (low-level machine code).
// Web3.js cannot directly understand this bytecode, so it needs the ABI to know:

// ✅ What functions exist in the contract (e.g., myUint(), setMyUint(uint256)).
// ✅ What parameters each function requires (e.g., setMyUint takes a uint256).
// ✅ What data types the functions return (e.g., myUint returns a uint256).

// How ABI Works in Your Code
// const contractInstance = new web3.eth.Contract(abiArray, contractAddress);

// Web3.js reads the ABI to create a contractInstance object.
// This lets you call functions like contractInstance.methods.myUint().call().
// Without the ABI, Web3 would not know how to interact with the contract.

// Summary
// 🔹 ABI is a blueprint that tells Web3 how to communicate with a smart contract.
// 🔹🔹🔹 Without ABI, Web3 cannot call or send transactions to the contract.
// 🔹 Every smart contract has its own ABI, generated after compilation.

