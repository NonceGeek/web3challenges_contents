// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

struct Player {
    address addr;
    uint256 amount;
}

contract bocai {
    
    Player[] bigs;
    Player[] smalls;
    uint256 public totalBigAmount;
    uint256 public totalSmallAmount;
    address owner;
    bool public isFinished;
    uint256 minBetAmount;
    uint256 public endTime;
    
    constructor(uint256 _min) {
        owner = msg.sender;
        isFinished = false;
        minBetAmount = _min;
        endTime = block.timestamp + 120;
    }
    
    // isBig = true, big; false, small
    function bet(bool isBig) public payable {
        require(!isFinished, "game must not finished!");
        require(msg.value >= minBetAmount, "bet's amount must > min");
        require(block.timestamp < endTime, "time not out");
        
        if(isBig) {
            // big 
            Player memory player = Player(msg.sender, msg.value);
            bigs.push(player);
            totalBigAmount += msg.value;
            
        } else {
            // else 
            Player memory player = Player(msg.sender, msg.value);
            smalls.push(player);
            totalSmallAmount += msg.value;
        }
    }
    
    // an zhao xia zhu jin e fen pei 
    function open() public payable {
        require(!isFinished, "game must not finished!");
        require(block.timestamp > endTime, "time not out");
        isFinished = true;
        
        // 【0 ~ 17】=> small{0,1,2,3,4,5,6,7,8}
        uint256 random = uint256(keccak256(abi.encode(block.timestamp, msg.sender, owner, totalBigAmount))) % 18;
        if(random <= 8) {
            // small  big=>small  
            // bonus = benjin + jiangjin( totalBigAmount * amount/totalSmallAmount  )
            for(uint256 i = 0 ;i < smalls.length; i ++) {
                Player memory player = smalls[i];
                uint256 bonus = player.amount + totalBigAmount * player.amount / totalSmallAmount * 90 / 100;
                payable(player.addr).transfer(bonus);
            }
            payable(owner).transfer(totalBigAmount * 10 / 100);
        } else {
            // big 
            for(uint256 i = 0 ;i < bigs.length; i ++) {
                Player memory player = bigs[i];
                uint256 bonus = player.amount + totalSmallAmount * player.amount / totalBigAmount * 90 / 100;
                payable(player.addr).transfer(bonus);
            }
            payable(owner).transfer(totalSmallAmount * 10 / 100);
        }
    }
    
    function getBalance() public view returns (uint256, uint256) {
        return (address(this).balance, totalBigAmount+totalSmallAmount);
    }
    
    function getNow() public view returns (uint256) {
        return block.timestamp;
    }
}