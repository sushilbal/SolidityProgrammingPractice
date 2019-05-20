pragma solidity ^0.5.0;

contract FinalDeed{
    
    address payable beneficiary;
    uint beneficiaryToReceive;

    uint amountTransfered;
    
    constructor (address payable _beneficiary, uint _beneficiaryToReceive) public payable{
        beneficiary=_beneficiary;
        beneficiaryToReceive=_beneficiaryToReceive;
    }
    
   
    modifier isValidAmount(uint amount){
        require((amountTransfered + amount) <=beneficiaryToReceive ," Not a valid amount to transfer");
        _;
    }
    
   
    function executeDeed() public payable {
        beneficiary.transfer(beneficiaryToReceive);
    }
    
    function executeDeed(uint amount)public payable  isValidAmount(amount){
        beneficiary.transfer(amount);
        amountTransfered+=amount;
    }
    
    
}