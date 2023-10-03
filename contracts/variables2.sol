// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract variables{
    
    /*
    there are three types of variables
    1) state variables - stored on blockchain 
    2) local variables - not saved on blockchain
    3) global variables - provide information about the contract deployed
    */

    // state variables - declared by the keyword public
    uint public num1 = 23;
    string public str1 = "hello";


    // local variables - declared by not using any keyword
    uint locInt = 100;
    string locStr = "wqweq";

    // global variables 
    uint public time = block.timestamp;
    address sender = msg.sender;

    // constants value's cannot be changed 
    // they are used to save gas fee

    string public constant A = "constant variable";
}