// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// state variables
// global variables
// function modifier
// function
// error handling

contract ownable {
    address public owner;

    constructor(){
        owner=msg.sender;
    }

    modifier onlyowner(){
        require(msg.sender == owner, "not owner");
        _;
    }

    function setowner(address _newowner) external onlyowner{
        require(_newowner != address(0), "invalid address");
        owner = _newowner;
    }

    function OnlyOwnerCanCall() external onlyowner{
        // code
    }

    function AnyoneCanCall() external{
        // code
    }

}