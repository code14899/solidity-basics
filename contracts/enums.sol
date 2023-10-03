// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract enumDemo {

    enum template{
        pending, 
        shipped,
        accepted,
        rejected,
        cancelled
    }

    template public pos;

    function get() public view returns (template){
        return pos;
    }

    function set(template _pos) public {
        pos = _pos;
    }

    function cancel() public {
        pos = template.shipped;
    }

    // we can set the value to an enum in the below following way also
    function setNum(uint _x) public {
        pos = template(_x);
    }

    function reset() public {
        delete pos;
    }

}