pragma solidity ^0.5.0;
//import "./FinalDeed.sol";

contract DeedExecution{
    
    
   // FinalDeed deed;
    address lawyer;
    uint amount;
    uint timeToStartTransfer = now+15 seconds;
    uint constant transferIntervalTimeInSeconds=10 seconds;
    
    
    constructor (address _lawyer,address payable _beneficiary) public payable{
        //deed=new FinalDeed(_beneficiary,msg.value);
        lawyer=_lawyer;
        amount=msg.value;
    }
        
    modifier lawyerOnly{
        require(msg.sender == lawyer ," Lawyer Only");
        _;
    }
    modifier isAboutTime{
        require (now >= timeToStartTransfer ," Please wait for correct time to transfer amount.") ;
        _;
    }
    
    function executeDeed(bool multipleTransaction, uint _maxNumberOfTimes) public lawyerOnly isAboutTime payable{
        uint count=0;
        if(multipleTransaction){
            uint maxNumberOfTimes = _maxNumberOfTimes <= 0 ?  1 : _maxNumberOfTimes;
            uint amountForEachTx=amount/maxNumberOfTimes;
            uint executionTime=now;
            do{
                //deed.executeDeed(amountForEachTx);
                executionTime=now;
                count++;
                 
            }while(now==(executionTime+10 seconds) && count < maxNumberOfTimes);
        }else{
            //deed.executeDeed();
        }
    }
    
}