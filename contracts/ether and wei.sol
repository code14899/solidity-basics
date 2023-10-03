
// pragma solidity ^0.8.20;

// contract unit {

//     // the deault unit used in ethereum is wei not ether
//     uint public weiVal = 1 wei;
//     uint public etherVal = 1 ether;


//     /*
//     gas limit is the limit we set on the gas that could be spend in a transaction
//     if the gas required for the transaction we want to make is more than the gas which we send
//         -> the transaction fails
//         -> we do not get the gas refund for the failed transaction

//     below is an example of a transaction that will definitely require more gas than we have send
//     */
//     uint public i = 1;
//     function infinite() public view returns(uint) {
//         while(true){
//             return i;
//         }
//     }

//     constructor(){
//         infinite();
//     }

// }

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract unit {

    uint public i = 12;

    function infinite() public view returns(uint){
        while(true){
            return i;
        }
    }
}