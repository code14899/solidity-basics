// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2;

// if we declare a function payable it can receive ether

contract Payable {

    function deposit() external payable {}

    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}

// 0xb7e0D9B6b54bd699eE086E29ABE4012D1186208D    -> contract deployed address