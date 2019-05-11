pragma solidity ^0.5.0;

contract EtherWallet{
    address owner;
    
    constructor() public{
        owner=msg.sender;
    }
    
    modifier ownerOnly(){
        require(msg.sender == owner);
        _;
    }
    
    function deposit() public payable{
        
    }
    
    function send(uint amount, address payable to) public ownerOnly{
        to.transfer(amount);
    }
    
    function balance()public view returns(uint){
        return address(this).balance;
    }
    
    function balanceOfOwner()public view ownerOnly returns(uint){
        return owner.balance;
    }
}