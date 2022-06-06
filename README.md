# 00-01 Solidity 基础语法之变量类型

之前，我们介绍了一个hello智能合约的部署和测试，接下来，我们着重介绍智能合约的语法。

## 1 数据类型

Solidity的数据类型非常丰富，下面我们通过一个表格介绍一下。

| 类型    | 描述                             | 示例                                       |
| ------- | -------------------------------- | ------------------------------------------ |
| string  | 字符串                           | "fisco-bcos","abc"                         |
| bool    | 布尔值                           | true或false                                |
| uint    | 无符号整数，256位，等价于uint256 | 20000000，1000000                          |
| int     | 有符号整数，256位，等价于int256  | -1001，200                                 |
| byte    | 字节类型，1个字节                | 0x1a，0x22                                 |
| bytes   | 字节数组                         | 0xa1a2a3,0xa1b2c3d4                        |
| address | 地址类型                         | 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 |

除了上表中所提到的数据类型，Solidity实际上也对整数类型和字节数组类型有着精确化的定义，比如uint8，uint16，uint24……uint256，int8，int16，int24……int256，bytes1，bytes2，bytes3……bytes32，从这样的定义看出，整数和字节类型每1个字节就会定义一种数据类型，这是因为在区块链系统存储数据成本是高昂的，类型定义越精确越好。

在上述类型，address类型是一种特殊的存在，它是Solidity语法中特有的数据类型，这涉及到EVM的账户模型设计。EVM中设计了2类账户，分别是外部账户和合约账户，外部账户就是我们调用合约或发起交易时的普通账户，合约账户则是代表合约部署后，也会获得和普通账户一样的账户地址。所以，无论外部账户还是合约账户，它们对外的呈现形式都是address类型。



## 2 状态变量与临时变量

熟悉面向对象编程的朋友会发现，contract定义的方式很像某些语言中的class，我们同样也可以在contract中定义类似于class中的成员变量，只不过在智能合约中，我们把它称其为状态变量。一旦被定义为状态变量，它也将被永久的存储在区块链上。除了状态变量，Solidity当中也可以在函数中使用临时变量，临时变量不会被存储在区块链中。

状态变量的定义语法为：

```solidity
Type [modifier] identifier；
```

Type为数据类型，identifier为变量名称，[modifier]是修饰符，可以使用public、private等来修饰该状态变量，代表该状态变量的访问权限，public类型的变量系统会直接为其提供同名的查询函数。此外，修饰符位置如果使用constant，则代表定义的是一个常量，在合约整个生命周期内不会发生变化。

临时变量的定义方式与状态变量类似，二者主要的区别是临时变量出现在函数内部，可以没有修饰符，也可以使用memory或storage，我们将在2.10小节详细介绍memory和storage的区别。

下面的合约代码，列举了一些定义变量的方式。

```solidity
pragma solidity^0.6.10;

contract hello {
	// 状态变量定义
    string public Msg;
    uint private age;
    // 常量定义
    bytes4 constant fid =  0xfa913621;
    constructor() public {
        Msg = "hello world";
    }

    function getDoubleAge() public view returns (uint) {
        // 临时变量定义
        uint dage = age * 2;
        return dage;
    }
}
```

## 3 部署到 Ethereum 测试网上

// TODO

## 4 提交你的 Challenges!

// TODO

