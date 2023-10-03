//SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract loopDemo{

    uint public i;
/*
    unbounded loops can hit the gas limit so they are rarely used
    break and continue statements can be used with loops
*/

    function loop() public{
        for(uint j=0; j<10; j++){

            if(j==2){
                continue;
            }
            if(j==5){
                break;
            }
            
            i+=j;

        }
    }

}
