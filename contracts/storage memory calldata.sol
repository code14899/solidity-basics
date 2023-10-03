// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

/*
    when we use a dynamic data type as a variable we need to declare its data location
    storage -> variable is a state variable
    memory -> 
*/
contract datalocation{

    uint[] public arr;
    mapping(uint => address) map;

    struct template{
        uint x;
    }

    mapping(uint => template) structs;

    function f() public {
        _f(arr, map, structs[0]);

        template storage map1 = structs[1];
        template memory map2 = template(0);   // it cannot be created in memory
    }

    function _f(
        uint[] memory _arr,
        mapping(uint => address) storage _map,      // the function containing a mapping can only be external or internal not public
        template memory _mystruct                   // the storage location of a mapping can only be storage not memory or calldata if it is given as parameter
    ) internal {
        
    }
}