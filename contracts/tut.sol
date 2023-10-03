// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract primitives {
    
    constructor() payable {}

    fallback() external payable{}

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function sendTransfer(address payable _to) external payable{
        bool sent = _to.send(20*1e18); 
    }

    function sendViaCall(address payable _to) external payable{
        bool sent = _to.send(20*1e18);
    }
}

