//SPDX-License-Identifier: MIT
pragma solidity^0.8.7;


contract bank_demo {

    string bankName;
    mapping(address=>uint256) balances;

    constructor(string memory _name) {
        bankName = _name;
    }

    function name() public view returns (string memory) {
        return bankName;
    }
    // who , bank, amount 
    function deposit(uint256 _amount) external payable {
        require(_amount == msg.value, "user' amount not equal value");
        require(_amount > 0, "amount must > 0");
        balances[msg.sender] += _amount;
    }
    // who, bank, amount
    function withdraw(uint256 _amount) external payable {
        require(_amount > 0, "amount must > 0");
        //require(balances[msg.sender] >= _amount, "user'balance not enough");

        balances[msg.sender] -= _amount; // 0.8版本判断了数学运算的溢出
        payable(msg.sender).transfer(_amount);
    }
    // from, to, amount
    function transfer(address _to, uint256 _amount) external  {
        require(_amount > 0, "amount must > 0");
        require(balances[msg.sender] >= _amount, "user'balance not enough");
        require(address(0) != _to, "to is zero address");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}