// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract array{

    uint[] public arr = [1,2,3];
    uint[] public arr2;
    uint[10] public arr3;

    function get(uint i) public view returns(uint){
        return arr[i];
    }

    function insert(uint i) public {
        arr.push(i);
    }

    function delLast() public {
        arr.pop();
    }

    function getLen() public view returns(uint){
        return arr.length;
    }

    // deleting an element resets its value to default value and do not change the size of the array
    function remove(uint ind) public{
        delete arr[ind];
    }

    // removing element by shifting

    function removeShift(uint _ind) public {
        
        for(uint i =_ind; i<arr.length-1; i++){
            arr[i]=arr[i+1];
        }
        arr.pop();
    }

    // removing array element by coping last element into place to move

    function removeCopy(uint _ind) public {
        arr[_ind]=arr[arr.length-1];
        arr.pop();
    }
}