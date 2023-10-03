// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract evault{


    address[] writeAccess;

    address validator1;
    address validator2;

    
    constructor(address _validator1, address _Validator2){
        writeAccess.push(msg.sender);
        validator1 = _validator1;
        validator2 = _Validator2;
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

    
    structTemplate[] public dataArray;
    mapping( string => structTemplate )  dataMap;  // case number => case
    mapping( string => string[] ) judgemap;       // judge => case number
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


    function add( string[9] calldata data) public accessAuthorization(msg.sender){

        
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

        judgemap[thisCase.judge].push(thisCase.caseNo);
        lawyerMap[thisCase.prosecutorLawyerName].push(thisCase.caseNo);
        lawyerMap[thisCase.defenderLawerName].push(thisCase.caseNo);


    }


    function structToArray(structTemplate memory _dataStruct) internal pure returns(string[] memory){

        string[] memory returningArray = new string[] (9);
        returningArray[0] = _dataStruct.caseNo ;
        returningArray[1] = _dataStruct.caseName;
        returningArray[2] = _dataStruct.judge;
        returningArray[3] = _dataStruct.prosecutorLawyerName;
        returningArray[4] = _dataStruct.defenderLawerName;
        returningArray[5] = _dataStruct.clientFiled;
        returningArray[6] = _dataStruct.clientDefending;
        returningArray[7] = _dataStruct.verdict;
        returningArray[8] = _dataStruct.url;

        return returningArray;

    }

    event log(string, string[] );

    function getJudgeCases( string memory _judgeName) public {

        string[] storage judgeCaseNoArray= judgemap[_judgeName];

        for(uint i=0;i<judgeCaseNoArray.length; i++){

            structTemplate memory tempStruct = dataMap[judgeCaseNoArray[i]];
            string[] memory resultArray = structToArray(tempStruct);
            emit log(_judgeName, resultArray);

        }
    }

    function getLawyerCase( string memory _lawyerName ) public {

        string[] storage lawyerCaseNoArray = lawyerMap[_lawyerName];

        for(uint i=0; i<lawyerCaseNoArray.length; i++){

            structTemplate memory tempStruct = dataMap[lawyerCaseNoArray[i]];
            string[] memory resultArray = structToArray(tempStruct);
            emit log(_lawyerName, resultArray);

        }
    }


    event logAll(uint, string[]);

    function getAllCases() public {

        for(uint i=0;i<dataArray.length;i++){

            string[] memory resultArray = structToArray(dataArray[i]);
            emit logAll(i+1, resultArray);
        }
    }
   


}

