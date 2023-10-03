// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ifelse{

    function compare(uint x) public returns (uint) {
    
        if(x<10){
            return 0;
        } else if(x<20){
            return 1;
        } else{
            return 2;
        }
    
    }

    /*
        -> if we use pure function gas is not needed for transaction
        -> a pure function does not alter the state of the blockchain
        -> a pure function also do not access any external data
    */
    function shorthand(uint x) public pure returns(uint) {
        return x<10 ? 10:11;
    }

}