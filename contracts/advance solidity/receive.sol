// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

/*
receive is simillar to fallback.

    ether is sent to contract 
            |
        msg.data exists
           /   \
         yes    no
        /         \  
fallback()       receive()

if receive is not defined than fallback executes even if there is no msg.data
if we just use receive and call a function that does not exits than the function call fails


*/


contract Receive {
    
    event Log(string _function,address sender,uint amount, bytes data);

    fallback() external payable {
       emit Log("fallback is called", msg.sender, msg.value, msg.data);
    }

    receive() external payable{
        emit Log("receive is called",msg.sender, msg.value, "");
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}