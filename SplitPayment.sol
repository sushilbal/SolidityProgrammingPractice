pragma solidity ^0.5.0;

contract SplitPayment{

    address owner;
    struct toPay{
        address payable toUser;
        uint amountToPay;
    }
    toPay[] toPayArray;

    constructor() public{
        owner = msg.sender;
    }

    modifier ownerOnly(){
        require(msg.sender == owner,"Only owner is allowed.");
        _;
    }

    function addToBePaid(address payable _toBePaid,uint amount)public ownerOnly{
        toPayArray.push(toPay(_toBePaid,amount));
    }

    function transferToEverybody() public ownerOnly payable{
        for(uint i = 0;i < toPayArray.length;i++){
            toPayArray[i].toUser.transfer(toPayArray[i].amountToPay);
        }
    }
}