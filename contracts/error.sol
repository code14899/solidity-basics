// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract error{

    function testRequire(uint _x) public pure{
        require(_x > 10, "input must be greater than 10")
    }
}