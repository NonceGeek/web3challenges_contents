// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

contract auction {
    
    // pai mai gong si 
    address payable owner;
    // mai fang
    address payable seller;
    // zui gao jia 
    uint256 public highestBid;
    address payable highestBider;
    // qi pai jia 
    uint256 public startBid;
    uint256 public endTime;
    bool isFinshed;
    
    
    event BidEvent(address _higher, uint256 highAmount);
    event EndBidEvent(address _winner, uint256 _amount);
    
    constructor(address _seller, uint256 _startBid) {
        owner = payable(msg.sender);
        seller = payable(_seller);
        startBid = _startBid;
        isFinshed = false;
        endTime = block.timestamp + 120;
        highestBid = 0;
    }
    
    function bid(uint256 _amount) public payable {
        require(_amount > highestBid, "amount must > highestBid");
        require(_amount == msg.value, "amount must equal value");
        require(!isFinshed, "auction already finished");
        require(block.timestamp < endTime, "auction not time out");
        
        // A 100 , B 200 
        if (address(0) != highestBider) {
            highestBider.transfer(highestBid);
        }
        highestBid = _amount;
        highestBider = payable(msg.sender);
        
        emit BidEvent(msg.sender, _amount);
    }
    
    function endAuction() public payable {
        require(!isFinshed, "auction already finished");
        require(msg.sender == owner, "only owner can end auction");
        isFinshed = true;
        seller.transfer(highestBid * 90 / 100);
        
        emit EndBidEvent(highestBider, highestBid);
    }
}