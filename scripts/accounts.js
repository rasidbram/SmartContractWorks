;(async () => {
    let accounts = await web3.eth.getAccounts() // Retrieves a list of available Ethereum accounts.
    console.log(accounts, accounts.length)

    let balance = await web3.eth.getBalance(accounts[0]) // Gets the balance (in Wei) of the first account.
    console.log('Balance of first account:', balance)

    let ethBalance = await web3.utils.fromWei(balance, 'ether') // Converts the balance from Wei (smallest unit of Ether) to ETH.
    console.log(ethBalance + ' eth')
})()
