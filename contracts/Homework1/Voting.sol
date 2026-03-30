// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(address => uint256) votes;
    mapping(address => bool) candidates;
    address[] candidateAddresses;

    modifier isCandidate(address _candidate){
        require(candidates[_candidate],"Not found candidate");
        _;
    }

    constructor(address[] memory _candidates) {
        candidateAddresses=_candidates;
        for(uint256 i=0;i<_candidates.length;i++){
            candidates[_candidates[i]]=true;
        }
    }

    function vote(address _candidate) external isCandidate(_candidate){
        votes[_candidate]++;
    }

    function getVotes(address _candidate) external view isCandidate(_candidate) returns (uint256) {
        return votes[_candidate];
    }

    function resetVotes() external {
        for(uint256 i=0;i<candidateAddresses.length;i++){
            votes[candidateAddresses[i]]=0;
        }
    }
}