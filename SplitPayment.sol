pragma solidity ^0.5.0;

contract SplitPayment{
    
    address owner;
    mapping(address=> uint) toPay;
    address payable[] toPayKey;
    
    constructor() public{
        owner=msg.sender;
    }
    
    modifier ownerOnly(){
        require(msg.sender == owner,"Only owner is allowed.");
        _;
    }
    
    function addToBePaid(address payable _toBePaid ,uint amount)public ownerOnly{
        toPay[_toBePaid]=amount;
        toPayKey.push(_toBePaid);
    }
    
    function transferToEverybody() public ownerOnly payable{
        for(uint i=0;i<toPayKey.length;i++){
            toPayKey[i].transfer(toPay[toPayKey[i]]);
        } 
    }
}