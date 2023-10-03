// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract mappingDemo {



    /*
        -> mapping in solidity is similar to map in c++
        -> mapping is a type of key value pair
        -> if we have'nt set the value of a key and try to access it, it returns the default value associated with
           the data type of "value"  
        -> to remove a key value pair from the map use keyword delete
    */
    mapping(address => uint) public myMap;

    function setAddress(address _add, uint _x) public {
        myMap[ _add ] = _x;
    }

    function get(address _add) public view returns(uint) {
        return myMap[ _add ];
    }

    function remove(address _add) public {
        delete myMap[ _add ];
    }


}

contract nestedMapping{

    mapping(address => mapping(uint => bool)) public nested;

    function get(address _add, uint _i) public view returns(bool _ans){
        _ans = nested[_add][_i];
    }

    function set(address _add, uint _i, bool _b) public {
        nested[_add][_i] = _b;
    }

    function remove(address _add, uint _i) public {
        delete nested[_add][_i];
    }

}