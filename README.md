# Decentralized Voting System

This smart contract allows users to create proposals and vote on them in a decentralized manner. It supports creating new proposals, voting, and ending the voting period.

## Features

- Create new proposals with a description and a voting duration.
- Users can vote on active proposals.
- Voting periods automatically end after the specified duration.
- The proposal's vote count is updated in real-time.

## How to Use

### Installation
1. Ensure you have a development environment set up with [Solidity](https://docs.soliditylang.org/) and [Remix](https://remix.ethereum.org/) or [Truffle](https://www.trufflesuite.com/).
2. Copy the contract code and deploy it on a compatible Ethereum network.

### Usage
1. **Create a Proposal:** Call `createProposal()` with a description and duration (in seconds) for the voting period.
2. **Vote on a Proposal:** Call `vote()` with the ID of the proposal you want to vote on.
3. **End a Proposal:** Once the voting period has ended, call `endProposal()` to finalize the vote and record the result.

### Example
```solidity
DecentralizedVoting voting = new DecentralizedVoting();
voting.createProposal("Implement feature X", 3600);
voting.vote(1);
voting.endProposal(1);
