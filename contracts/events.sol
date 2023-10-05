// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2;

contract events {
    event Log(string message, uint val);
    // if we want to search for a particular event by the parameter that have been logged than we use the keyword indexed

    event IndexedLog(address indexed sender, uint val);     // upto three parameters can be index

    function example() external {
        emit Log("called", 1234);
        emit IndexedLog(msg.sender, 789);
    }
}