pragma solidity ^0.5.0;

contract Voting{
    struct Candidate{
        string candidateName;
        uint numberOfVotes;
        uint id;
    }

    struct Ballot {
        address voter;
        Candidate[] candidates;
    }
    Ballot ballot ;
    mapping(address => bool) votersVotingStatus;
    address public admin;
    uint nextId = 0;
    uint public voterRegisterationId = 0;

    constructor() public{
        admin = msg.sender;
    }

    modifier onlyAdmin{
        require(msg.sender == admin,"Only allowed to add candidate.");
        _;
    }

    modifier onlyValidVoters{
        require(votersVotingStatus[msg.sender]==false ," Already Voted.");
        _;
    }
    
    modifier onlyFromChoiceOfCandidates(uint choice){
        require(choice <= ballot.candidates.length ,"Please give a valid choice.");
        _;
    }
    function addCandidate(string calldata _candidateName) external onlyAdmin{
        Candidate memory candidate = Candidate(_candidateName,0,nextId);
        ballot.candidates[nextId] = candidate;
        nextId++;
    }

    function addVoter(address _voter) external onlyAdmin{
        votersVotingStatus[_voter] = false;
        voterRegisterationId++;
    }

    function castBallot(uint choice) external onlyValidVoters onlyFromChoiceOfCandidates(choice){
        ballot.candidates[choice].numberOfVotes += 1;
    }

    function revealWinner() external onlyAdmin returns (string memory){
        string memory candidateName;
        uint voteCount=0;
        
        for(uint i = 0; i <= nextId;i++){
          voteCount = ballot.candidates[i].numberOfVotes > voteCount ? 
                        voteCount = ballot.candidates[i].numberOfVotes : voteCount ;
          candidateName=ballot.candidates[i].candidateName;
        }
        return candidateName;
    }
}