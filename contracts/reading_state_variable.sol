// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;


contract simplestorage{
    uint public num = 12;

    /*
    if we want to only read data from blockchain we can declare the function as view 
    A view function can do more than just returning a state variable, such as:
        1)Performing calculations or logic based on the state variables or the input parameters.
        2)Calling other view functions or pure functions within the same contract or from other contracts.
        3)Accessing some global variables, such as block, msg, tx, and this3.
        4)Emitting events, although they will not be logged by external calls

    */

    // this function will not cost any gas fees
    function get() public view returns(uint){
        return num;
    }

    // to read from this function it will cost some gas fees
    function getcost() public returns(uint){
        return num;
    }

}