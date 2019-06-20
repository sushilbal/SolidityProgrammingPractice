pragma solidity ^0.5.0;

contract MultiPaymentDeed{
    enum State {INITIAL,FIRST,SECOND,THIRD,FOURTH,FIFTH}
    State public currentState ;

    address public lawyer;
    address payable beneficiary;
    uint public trustFund;
    uint public startTime = now + 10 ;
    uint public waitTimeForNextPayment;
    uint public gapBeforeNextPayment;

    constructor(
        address _lawyer,
        address payable _beneficiary,
        uint _gapBeforeNextPayment
    ) public payable{
        lawyer = _lawyer;
        beneficiary = _beneficiary;
        gapBeforeNextPayment = _gapBeforeNextPayment;
        waitTimeForNextPayment = startTime+gapBeforeNextPayment;
        trustFund=address(this).balance;
        currentState=State.INITIAL;
    }

    modifier lawyerOnly{
        require(msg.sender == lawyer, "Only Lawyer is allowed.");
        _;
    }

    modifier isTimeToPay{
        require(getState() != State.INITIAL," Not Yet !");
        _;
    }

    function isNotInInitialStage() internal returns (bool){
        if(now >= startTime){
            currentState = State.FIRST;
            return true;
        }
        return false;
    }

    function getState() internal returns (State){
        if (isNotInInitialStage() && now >= waitTimeForNextPayment){
            if(currentState == State.INITIAL){
                currentState = State.FIRST;
            }else if (currentState == State.FIRST){
                currentState = State.SECOND;
            }else if (currentState == State.SECOND){
                currentState = State.THIRD;
            }else if (currentState == State.THIRD){
                currentState = State.FOURTH;
            }else{
                currentState = State.FIFTH;
            }
        }
        return currentState;
    }   

    function balanceOf() public view returns(uint){
        return address(this).balance;
    }
    
    function executeDeed() public lawyerOnly isTimeToPay {
        beneficiary.transfer(amnountToTransfer());
        waitTimeForNextPayment = now + gapBeforeNextPayment;
    }

    function amnountToTransfer() internal view returns(uint){
        uint installmentAmount = trustFund/5;
        if(currentState == State.FIFTH){
            return address(this).balance;
        }else{
            return installmentAmount;
        }
    }
}