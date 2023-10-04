// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2;

// delegate call executes code in another contract 
// in the context of the contract that called it


/*
Normal call ->

A calls B, sends 100 wei
        B calls c, send 50 wei

A ---> B ---> C
                msg.sender = B
                msg.value = 50 wei
                executes code on C's state variables
                if there is a function that use eth, it uses eth stored in C

Delegate call ->

A calls B, sends 100 wei
        B delegateCall C

A ---> B ---> C
                msg.sender = A
                msg.value = 100
                execute code on B's state variables
                use ETH in B
A called B , and B delegate Calls C, in B msg.sender is A. delegate call preserves the context of call so msg.sender in C is also A

*/
contract TestDelegateCall {
    
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    uint public num;
    address public sender;      // -> the order of these state variables should be same as defined in text contract we can append anything at the end but not iin between or middle
    uint public value;

    // we can't set value for delegate call
    function setVars (address _test, uint _num) external payable {
        (bool success, bytes memory data) = _test.delegatecall(abi.encodeWithSignature("setVars(uint256)",_num));  // it is necessary to represent full uint256
        require(success, "delegate call fails");
    }
}