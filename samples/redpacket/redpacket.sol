//SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract redpacket {
    address payable public tuhao;
    uint256 public count;
    uint256 public left;
    uint256 public total;
    bool    isRand;
    

    mapping(address=>bool) isQiang;

    constructor(uint256 _count, bool _isRand) payable {
        isRand = _isRand;
        count  = _count;
        left   = count;
        total  = msg.value;
        tuhao = payable(msg.sender);
    }

    function qiang() public payable {
        require(!isQiang[msg.sender], "user already qiang");
        require(left > 0, "repacket does not left");
        left --;
        isQiang[msg.sender] = true;
        uint256 amount = 0;
        if(!isRand) {
            amount = total/count;
        }
        
        payable(msg.sender).transfer(amount);

    }

    function kill() public payable {
        require(tuhao == msg.sender);

        selfdestruct(tuhao);
    }
}