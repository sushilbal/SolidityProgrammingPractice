pragma solidity ^0.5.1;

contract MultiSig{
    address[] public approvers;
    uint public quorum;

    struct Transfer{
        uint id;
        uint amount;
        address payable to;
        uint approvals;
        bool sent;
    }

    mapping(uint => Transfer) transfers;
    mapping (address => mapping(uint=>bool)) approvals;
    uint nextId = 0;

    constructor(address[] memory _approvers,uint _quorum) public payable{
        approvers = _approvers;
        quorum = _quorum;
    }

    modifier isNotSent(uint id){
        require(transfers[id].sent != true,"Transfer has been done.");

        _;
    }
    modifier onlyApprovers{
        bool allowed = false;
        for (uint i = 0;i<approvers.length;i++){
            if(approvers[i] == msg.sender){
                allowed = true;
                break;
            }
        }
        require(allowed, "You cannot initiate a Transfer.");
        _;
    }

    function createTransfer(uint amount, address payable to) external onlyApprovers{
        transfers[nextId] = Transfer(nextId,amount,to,0,false);
        nextId++;
    }

    function sendTransfer(uint id) external isNotSent(id) onlyApprovers returns (bool,string memory){
        bool complete = false;
        string memory status = "Waiting for 2nd approver.";
        if(approvals[msg.sender][id] == false){
            approvals[msg.sender][id] = true;
            transfers[id].approvals++;
        }

        if(transfers[id].approvals >= quorum){
            transfers[id].sent = true;
            address payable to = transfers[id].to;
            uint amount = transfers[id].amount;
            to.transfer(amount);
            complete = true;
            status = "Completed!";
        }
        return (complete,status);
    }
}

/**
["0xca35b7d915458ef540ade6068dfe2f44e8fa733c","0x14723a09acff6d2a60dcdf7aa4aff308fddc160c","0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db"],2
 */