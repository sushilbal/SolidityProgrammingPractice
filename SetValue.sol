pragma solidity ^0.5.0;

contract SetValue{
    uint public aValue;
    string public aString;

    constructor(uint _aValue,
        string memory _aString) public{
            aValue=_aValue;
            aString=_aString;
        }
    
    function settingValue(uint _aValue) public{
        aValue=_aValue;
    }

}