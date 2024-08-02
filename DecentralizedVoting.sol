// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedVoting {
    struct Proposal {
        uint256 id;
        string description;
        uint256 voteCount;
        bool isActive;
        uint256 endTime;
    }

    uint256 public proposalCount;
    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public voted;

    event ProposalCreated(uint256 id, string description, uint256 endTime);
    event Voted(uint256 proposalId, address voter, uint256 voteCount);
    event ProposalEnded(uint256 id, uint256 voteCount);

    function createProposal(string memory description, uint256 duration) external {
        require(duration > 0, "Duration must be greater than zero");

        proposalCount += 1;
        uint256 endTime = block.timestamp + duration;
        
        proposals[proposalCount] = Proposal({
            id: proposalCount,
            description: description,
            voteCount: 0,
            isActive: true,
            endTime: endTime
        });

        emit ProposalCreated(proposalCount, description, endTime);
    }

    function vote(uint256 proposalId) external {
        Proposal storage proposal = proposals[proposalId];
        require(proposal.isActive, "Proposal is not active");
        require(block.timestamp < proposal.endTime, "Voting period has ended");
        require(!voted[proposalId][msg.sender], "You have already voted");

        proposal.voteCount += 1;
        voted[proposalId][msg.sender] = true;

        emit Voted(proposalId, msg.sender, proposal.voteCount);
    }

    function endProposal(uint256 proposalId) external {
        Proposal storage proposal = proposals[proposalId];
        require(proposal.isActive, "Proposal is not active");
        require(block.timestamp >= proposal.endTime, "Voting period is not over");

        proposal.isActive = false;

        emit ProposalEnded(proposalId, proposal.voteCount);
    }

    function getProposal(uint256 proposalId) external view returns (string memory, uint256, bool, uint256) {
        Proposal storage proposal = proposals[proposalId];
        return (proposal.description, proposal.voteCount, proposal.isActive, proposal.endTime);
    }
}
