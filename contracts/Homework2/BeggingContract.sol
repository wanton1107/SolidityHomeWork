// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/security/ReentrancyGuard.sol";

contract BeggingContract is ReentrancyGuard{
    address owner;
    mapping(address => uint256) public contributors;
    mapping(uint256 => address) public top3Address;

    event Contribute(address indexed contributor,uint256 amount);
    event Withdraw(address indexed owner,uint256 amount);

    modifier onlyOwner() {
        require(owner==msg.sender,"No permission");
        _;
    }

    constructor(){
        owner=msg.sender;
    }

    receive() external payable {
        require(msg.value>0,"No transfer");

        contributors[msg.sender]+=msg.value;

        emit Contribute(msg.sender, msg.value);

        _calculateTop3();
    }

    function donate() external payable {
        require(msg.value>0,"No transfer");
        
        contributors[msg.sender]+=msg.value;

        emit Contribute(msg.sender, msg.value);

        _calculateTop3();
    }

    function withdraw() external onlyOwner nonReentrant {
        uint256 balance=address(this).balance;
        require(balance>0,"No balance to withdraw");
        (bool success,)=payable(msg.sender).call{value:balance}("");
        require(success,"Transfer fail");

        emit Withdraw(msg.sender, balance);
    }

    function _calculateTop3() internal {
        uint256 sum=contributors[msg.sender];

        // 前三处理逻辑
        if(top3Address[1]==msg.sender){
            return;
        }

        if(top3Address[2]==msg.sender){
            if(sum>contributors[top3Address[1]]){
                top3Address[2]=top3Address[1];
                top3Address[1]=msg.sender;
            }
            return;
        }

        if(top3Address[3]==msg.sender){
            if(sum>contributors[top3Address[2]]){
                if(sum>contributors[top3Address[1]]){
                    top3Address[3]=top3Address[2];
                    top3Address[2]=top3Address[1];
                    top3Address[1]=msg.sender;
                }else{
                    top3Address[3]=top3Address[2];
                    top3Address[2]=msg.sender;
                }
            }
            return;
        }

        // 非前三处理逻辑
        if(sum>contributors[top3Address[3]]) {
            if(sum>contributors[top3Address[2]]) {
                if(sum>contributors[top3Address[1]]) {
                    top3Address[3]=top3Address[2];
                    top3Address[2]=top3Address[1];
                    top3Address[1]=msg.sender;
                }else{
                    top3Address[3]=top3Address[2];
                    top3Address[2]=msg.sender;
                }
            }else{
                top3Address[3]=msg.sender;
            }
        }
    }
}