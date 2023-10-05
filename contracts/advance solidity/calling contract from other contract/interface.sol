// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2;

// we want to access the function of contract counter already deployed
// to do this we can create an interface 

interface ICounter {
    function count() external view returns(uint);   //count is not a function in counter yet we are able to use it as solidity
                                                    // provide a getter function by the same name by default
    function inc() external ;
}

contract CallInterface {

    uint public count;
    function IncAndGet(address _counterAddress) public {   // in place of external if we 
        ICounter(_counterAddress).inc();                    //  are writing public it is not working
        count = ICounter(_counterAddress).count();
    }
}

contract Counter {

    uint public count;

    function inc() external {
        count += 1;
    }
    
    function dec() external {
        count -= 1;
    }
}

