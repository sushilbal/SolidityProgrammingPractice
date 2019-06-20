pragma solidity ^0.5.8;

contract Escrow{
    address payable public seller;
    address public buyer;
    address public lawyer;

    uint amountToBePaid;

    constructor(address payable _seller,
    address _buyer,
    uint _amountToBePaid)public payable{
        buyer=_buyer;
        seller=_seller;
        lawyer=msg.sender;
        amountToBePaid=_amountToBePaid;
    }   

    modifier onlySeller{
        require(msg.sender == buyer ," Only Buyer can send money.");
        _;
    }
    modifier onlyAmountToBePaid{
        require(address(this).balance<=amountToBePaid ,"Will not accept more that the required amount.");
        _;
    }

    modifier amountBalance{
        require(address(this).balance == amountToBePaid,"Not Sufficient balance Yet.");
        _;
    }
    modifier onlyLawyer{
        require(msg.sender == lawyer,"Only Lawyer can relese the title");
        _;
    }
    function deposit() public payable onlySeller onlyAmountToBePaid{
    }

    function releaseTitle() public onlyLawyer amountBalance{
        seller.transfer(amountToBePaid);
    }

    function balanceOf() public view returns (uint){
        return address(this).balance;
    }


}

