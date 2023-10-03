// SPDX-License-Indetifier: MIT
pragma solidity ^0.8.2;

contract A {
    function ret() public pure virtual returns(string memory){
        return "A";
    }
}

contract B is A {
    function ret() public pure virtual override returns(string memory){
        return "B";
    }
}

contract C is A {
    function ret() public pure virtual override returns(string memory){
        return "C";
    }
}

contract D is B, C {

    // d.ret() returns "c" 
    // since c is the right most contract with function ret
    function ret() public pure virtual override(B, C) returns(string memory){


        // the function of parent contract can be called by the following method
        B.ret();

        // another way to call the function of parent contract is using keywork super
        super.ret();
    }
}

// Inheritance must be ordered from “most base-like” to “most derived”.
// Swapping the order of A and B will throw a compilation error.

contract F is A, B {
    function ret() public pure override(A, B) returns (string memory) {   // it can also be ovveride(B,A). both are same
         super.ret();
    }
}

/*
    -> we can call the function of base contract by two ways
    -> by using super keyword
        -> if a function is overrided in more than one contract it will be called from all the contract in the order of inheritance
    -> by explicitly difing the contract from ehre we want to call the function


*/
