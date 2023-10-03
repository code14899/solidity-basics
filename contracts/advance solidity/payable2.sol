// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Payable {
    // payable address can send eth via transfer or send
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }


    function deposit() payable public {}

    // create a payable funtion to send ether to this contract
    // call this function with some ether
    // the balance of this contract will automatically updated

    function getBalance() public view returns(uint){

        return address(this).balance;
    }
}