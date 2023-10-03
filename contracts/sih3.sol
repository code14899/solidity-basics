// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract evault{


    address[] writeAccess;


    constructor(){
        writeAccess.push(msg.sender);

    }


    struct structTemplate{
        string caseNo;
        string caseName;
        string judge;
        string prosecutorLawyerName;
        string defenderLawerName;
        string clientFiled;
        string clientDefending;
        string verdict;
        string url;
    }

    function giveAccess(address _add) public {
        require(msg.sender == writeAccess[0]);
        writeAccess.push(_add);

    }
    
    structTemplate[] public dataArray;
    mapping( string => structTemplate )  dataMap;  // case number => case
    mapping( string => string[] ) judgeMap;       // judge => case number
    mapping( string => string[] )  lawyerMap;     // lawyer name => case number

    modifier accessAuthorization(address _add){
        bool access = false;
        for(uint i=0;i<writeAccess.length;i++){
            if(writeAccess[i]==_add){
                access = true;
                break;
            }
        }
        require(access, "do not have write access");
        _;
    }


    event DataAdded(string , string);
    function addData( string[9] calldata data) public accessAuthorization(msg.sender){


        // adding the data in the thisCase struct
        structTemplate memory thisCase;

        thisCase.caseNo = data[0];
        thisCase.caseName = data[1];
        thisCase.judge = data[2];
        thisCase.prosecutorLawyerName = data[3];
        thisCase.defenderLawerName = data[4];
        thisCase.clientFiled = data[5];
        thisCase.clientDefending = data[6];
        thisCase.verdict = data[7];
        thisCase.url = data[8];

        // defining the mapping
        dataArray.push(thisCase);
        dataMap[thisCase.caseNo] = thisCase; 

        judgeMap[thisCase.judge].push(thisCase);
        lawyerMap[thisCase.prosecutorLawyerName].push(thisCase);
        lawyerMap[thisCase.defenderLawerName].push(thisCase);

        emit DataAdded(thisCase.judge, thisCase.caseNo);

    }



    function getJudgeCases( string memory _judgeName) public view returns(structTemplate[] memory){
        return judgeMap[_judgeName];
        
    }

    function getLawyerCase( string memory _lawyerName ) public view returns(structTemplate[] memory){

        return lawyerMap[_lawyerName];
    }


    function getAllCases() public view returns(structTemplate[] memory){
        return dataArray;
    }
   


}

