// SPDX-License-Indetifier: MIT
pragma solidity ^0.8.2;

contract A {
    string public name = "contract A";

    function getName() public view returns(string memory){
        return name;
    }
}

