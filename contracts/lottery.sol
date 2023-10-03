// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract lottery{
    address public owner;
    address payable[] public players;
    address[] public winners;
    uint public lotteryId;

    // constructor runs when the contract is deployed
    constructor(){
        owner=msg.sender;
        lotteryId = 0; 
    }

    //enter function
    function enter() public payable{
        require(msg.value >= 0.1 ether);
        players.push(payable(msg.sender));
    }

    //get players
    function getPlayers() public view returns (address payable[] memory){
        return players;
    }

    //get balance
    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    //get lottery id
    function getLotteryId() public view returns (uint){
        return lotteryId;
    }

    function getRandomNumber() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    //pick winner!
    function pickWinner() public {
        require(msg.sender==owner);
        uint randomIndex = getRandomNumber() % players.length;
        players[randomIndex].transfer(address(this).balance); 
        winners.push(players[randomIndex]);
        lotteryId++;

        // clear the player array
        players = new address payable[](0);
    }

    function getWinners() public view returns (address[] memory){
        return winners;
    }
}