// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Immutable{

    /*
    we can set the immutable variable only when the contract is deployed
    once it is deployed we can never change it
    immutables are used to save cost
    they can be declared only when either the variable is initialized or inside a constructor
    reading an immutable is cheaper than reading a state variable
    regular variables are stored on blockchain but the immutable variable is inserted with the bytecode of the contract, thats why it is cheaper
    */

    uint public immutable a;
    
    // uint public immutable a = 123;       
    // if we use this line than we have to remove the assignment of value from constructor
    
    
    constructor(uint _a){
        a = _a;
    }

    function getimmu() public returns(uint){
        return a;
    }

}