// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

/*
-> if we call a function and it does not existes in our contract than fallback executes
-> it is generally used to transfer eth to contract
*/

contract Fallback {
    // fallback is generally used to enable contract to receive eth
    // when another account tries to directly send eth to this contract fallback gets executed
    // to enable a fallback function to receive ether declare fallback as payable
    fallback() external payable {}

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}