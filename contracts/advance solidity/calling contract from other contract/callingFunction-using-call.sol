// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2;

// below is a helper contract

contract testCall {
    string public message;
    uint public x;  // default state visibility is internal

    event Log(string message);

    fallback() external payable{
        emit Log("fallback was called");
    }

    function set(string memory _message, uint _x) external payable returns(bool, uint) {
        message = _message;
        x = _x;
        return(true, 999);
    }

    function getBal() public view returns(uint){
        return address(this).balance;
    }
}

// below is the method to use call to call the function of another contract

contract Call {

    bytes public data;
    function set1(address _testAdd) external payable {
        // first parameter of encodeWithSignature is the name of the function which we are calling
        // there is no space between different words that come in the first parameter
        // the subsequent paremeters of encodeWithSignature are the parameters of the set function defined in testCall contract
        // it returns two values, first is the bool which tells whether the call was successful or not
        // the second value is the output that we get after calling the function set
        // second value is encoded in bytes
        // we can also specify the ether which we want to send in the contract and also the gass limit

        // since we are also sending ether to the contract we need to make this function payable so that it also have eth to send
        (bool _isSuccess, bytes memory _data) = _testAdd.call{value : 133}(
            abi.encodeWithSignature(
                "set(string,uint256)", "calling", 123
            )
        );   

        require(_isSuccess, "calling contract failed");
        data = _data;

    }

// if we call a function which does not exist in test contract than fallback function of test contract gets executes

    function doesNotExist(address _test) external {
        (bool _success, ) = _test.call(abi.encodeWithSignature("doesNotExit()"));
        require(_success, "call failed");
    }

    function getBal() public view returns(uint){
        return address(this).balance;
    }
    
}