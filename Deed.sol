pragma solidity ^0.5.0;

contract Deed{
    address lawyer;
    address payable beneficiary;
    uint timeToExecute;

    constructor (address _lawyer,address payable _beneficiary) public payable{
        timeToExecute = now + 1 minutes;
        lawyer = _lawyer;
        beneficiary = _beneficiary;        
    }

    modifier lawyerOnly(){
        require(msg.sender == lawyer , "Seems that you are not the lawyer !!");
        _;
    }

    modifier onlyOnTime(){
        require(now >= timeToExecute , "It seems you are too eager for money !!");
        _;
    }
    
    function deposit() payable public {
        
    }
    
    function balanceOf()view public returns(uint){
        return address(this).balance;
    }

    function executeTheDeed() public payable lawyerOnly onlyOnTime{
        beneficiary.transfer(address(this).balance);
    } 
}