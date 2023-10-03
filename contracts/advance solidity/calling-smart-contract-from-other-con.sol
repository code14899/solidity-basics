// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2;

contract callTestContract {
    // calling function setX from testContract
    function set1(address _testContractAdd, uint _x) external {
        testContract(_testContractAdd).setX(_x);
    }

    // more intuative way of calling 
    function set2(testContract _test, uint _x) external {
        _test.setX(_x);
    }

    // calling get function from testContract
    function get1(testContract _test) external view returns(uint _x){
        _x = _test.getX(); 
    }


    // how to send eth to another contract
    function setXAndGetEth1(testContract _test, uint _x) external payable {
        _test.setXAndReceiveEther{value: msg.value}(_x);
    }

    // how to get multiple value from other contract
    // 
    function getXAndValue1(address _test) public view returns(uint _x,uint _valueInContract){
        (_x, _valueInContract) = testContract(_test).getXAndValue();
    }
}

contract testContract {

    uint public x;
    uint public valueInContract;

    function setX(uint _x) public {
        x = _x;
    }

    function getX() public view returns(uint){
        return x;
    }

    function setXAndReceiveEther(uint _x) external payable {
        x = _x;
        valueInContract = msg.value;
    }

    function getXAndValue() external view returns(uint , uint){
        return ( x, valueInContract);
    }

}