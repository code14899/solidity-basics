// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract schedule{

    struct template {
        string text;
        bool completed;
    }

    template[] public todo;

    function create(string calldata _text) public {
        // 3 ways of initilizing a struct

        todo.push(template(_text, false));

        template memory todo1;
        todo1.text = _text;     // completed is initialized by fase by default

        todo.push(todo1);
    }

    function get(uint _index) public view returns (string memory text, bool completed){
        template storage todo1 = todo[_index];
        return ( todo1.text, todo1.completed);
    }

    function togglecomplete(uint _index) public {
        template storage todo1 = todo[_index];          // to update data we use storage
        todo1.completed = !todo1.completed;

        // m2 to do the same
        // todo[_index].completed = !todo[_index].completed;
    }    

    // use storage to load dynamic data that we will change
    // use memory to load that that we only want to read
    // use calldata to pass function arguments when we only want to read the argument and dont want to make any change to it
}