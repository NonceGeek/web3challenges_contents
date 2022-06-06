pragma solidity^0.6.10;

import "./IERC20.sol";

contract exchange {
    
    IERC20 tokenA;
    IERC20 tokenB;
    address owner;
    uint256 priceA; // 1 A = xB * (10 ** B.decimals) 
    uint256 priceB; // 1 B = xA * (10 ** A.decimals)
    uint256 public leftAmount;
    //mapping(address=>uint256) balancesB;
    
    event PriceChanged(uint256 _amountA, uint256 _amountB);
    constructor(address _tokenA, address _tokenB) public {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        owner  = msg.sender;
    }
    
    modifier onlyowner() {
        require(msg.sender == owner, "only owner can do");
        _;
    }
    
    function setPrice(uint256 _amountA, uint256 _amountB) public onlyowner {
        uint256 amountB = _amountB * (10 ** 8);
        priceA = amountB / _amountA ;
        uint256 amountA = _amountA * (10 ** 8);
        priceB = amountA / _amountB;
        
        emit PriceChanged(_amountA, _amountA);
    }
    
    function depositA(uint256 _amountA) public {
        require(_amountA > 0);
        require(tokenA.balanceOf(msg.sender) >= _amountA, "user's balance must enough");
        require(tokenA.transferFrom(msg.sender, address(this), _amountA));
        leftAmount = _amountA;
        
    }
    
    function tokenExchange(uint256 _amountB) public {
        require(_amountB > 0);
        uint256 realAmountA = priceB * _amountB / (10 ** 8); 
        if(realAmountA >= leftAmount) {
            // A 缺少
            tokenA.transfer(msg.sender, leftAmount);
            tokenB.transferFrom(msg.sender, owner, leftAmount * priceA / (10 ** 8));
            leftAmount = 0;
        } else {
            tokenA.transfer(msg.sender, realAmountA);
            tokenB.transferFrom(msg.sender, owner, realAmountA * priceA / (10 ** 8));
            leftAmount -= realAmountA;
        }
        
    }
    
}

