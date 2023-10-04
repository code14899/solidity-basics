// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2;

/*
there are three ways to send ether to an account or to a smart contract
1) transfer
    -> the gas limit while using transfer to send eth is 2300 gas
    -> it do not returns any bool value telling if transaction fails or not
    -> if the gas required for the transaction is more than 2300 the transaction fails
    -> gas used is not returned if transfer fails
    -> changes done to state variables are reverted

2) send
    -> send is like  transfer
    -> it returns a bool true if transaction is successful and false is transaction is not successful
    -> gas limit for the transction is 2300 gas 
    -> if transaction fails gas used is not reverted
    -> even if transaction fails if we have made any canges to a state variable it stays
    -> The require function reverts the state to the original state if the condition is not met, and returns the unused gas to the caller.
    -> However, the gas that was already consumed by the contract logic before the require statement is not refunded
    -> send is generally never used
    -> send function is vulnerable to re enterancy attack

3) call
    -> 
*/

contract  sendEther {

    constructor() payable{}
    receive() external payable {}

    function sendViaTransfer(address payable _to, uint amount) external payable {
        _to.transfer(amount*1e18);
    }

    function sendViaSend(address payable _to, uint amount) external payable {
        bool sent = _to.send(amount*1e18);
        require(sent, "call failed");
    }
}