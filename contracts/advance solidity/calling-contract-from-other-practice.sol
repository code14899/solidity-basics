// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract callTestContract {

    // setting the value of x 
    function setX1(address _testContractAddress, uint _x) public {
        testContract(_testContractAddress).setX(_x);
    }

    // another way to refer to contract testContract
    function setX2(testContract _test, uint _x) public {
        _test.setX(_x);
    }

    function getX1(address _testContractAddress) public view returns(uint _x) {
        _x = testContract(_testContractAddress).getX();
    }

    function setXAndEth(testContract _testAddress, uint _x) public payable {
        _testAddress.setXAndTransferEth{value: msg.value}(_x);
    }

    function getXandvalue1(testContract _test) public view returns(uint _x, uint _value){
        (_x, _value) = _test.getXandValue();
    }


}

contract testContract {

    uint x;
    uint ethValueInContract;

    function setX(uint _x) external {
        x=_x;
    }

    function getX() external view returns(uint _x){
        _x = x;
    }

    function setXAndTransferEth(uint _x) external payable {
        x = _x;
        ethValueInContract = msg.value;
    }

    function getXandValue() external view returns(uint _x, uint _value){
        _x = x;
        _value = ethValueInContract;
    }


}