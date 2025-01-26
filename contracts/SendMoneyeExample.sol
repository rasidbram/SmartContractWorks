// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract SendWithdrawMoney {
    uint256 public balanceRecieved; // variable that will store amount received

    function deposit() public payable {
        balanceRecieved += msg.value; //add value from sending to balancesRecieved variable
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance; //returns amount of funds in contract
    }

    function withdrawAll() public {
        address payable to = payable(msg.sender); // assign the msg sender as an address variable
        to.transfer(getContractBalance()); // send the funds stored in balanceRecieved to the msg sender
    }

    function withdrawToAddress(address payable to) public {
        to.transfer(getContractBalance()); // send the funds from contract balance to a specific address variable
    }
}
