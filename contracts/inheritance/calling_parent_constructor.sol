// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract A{

    string varA;

    constructor(string memory _varA){
        varA = _varA;
    }
}

contract B{

    string varB;

    constructor(string memory _varB){
        varB=_varB;
    }
}

contract C is A("a") , B {

    string varC;
    constructor(string memory _varB, string memory _varC) B(_varB){
        varC = _varC;
    }
}


// -> order of constructor call is equal to order of inheritance
