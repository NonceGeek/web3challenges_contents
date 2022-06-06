## 01-01 部署你的第一个 Solidity 合约

智能合约的概念最早由*尼克·萨博*在1994年提出，受当时的计算机技术发展限制，智能合约只能停留在概念阶段。2013年，以太坊创始人Vitalik Buterin受比特币脚本启发，在以太坊白皮书中提出了智能合约的实现方式。为了编写智能合约，以太坊又专门设计了一门名为Solidity的编程语言，可以说它是第一款真正意义上的智能合约编程语言。接下来，我们将会简单了解一下Solidity，包括开发环境的说明，以及智能合约版“hello world”的实践。

##  1 开发环境说明

为了支持智能合约的运行，以太坊提供了EVM（Ether Virtual Machine，以太坊虚拟机），使用特定的Solc编译器可以将智能合约代码编译为EVM机器码，这些机器码可以在EVM中运行。如下图所示。

![image-20211209152955771](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqgjnzx9j20nw09o752.jpg)

上面简单的介绍了智能合约的运行过程，通过这些介绍，我们可以得出一个结论，Solidity智能合约若想运行，需要有Solc编译器和EVM，EVM依赖于区块链节点，只要是支持EVM的区块链系统都可以作为开发节点使用，例如FISCO-BCOS或Geth；至于编译器的问题，建议使用内嵌编译器的在线IDE环境，例如 Remix。

> http://remix.ethereum.org/

如果单纯学习Solidity开发，可能使用Remix也就够了，因为它内部也内嵌了EVM虚拟机，可以模拟智能合约的运行。如果要学习应用开发，则启动一个节点是有必要的。为了简化操作，下面的演示代码将使用Remix作为演示环境。

## 2 第一个智能合约 

通过前面的开发环境介绍，我们对智能合约有了一个基本的印象。如果把区块链比作数据库的话，智能合约类似于运行在数据库上的SQL语句，因此也可以把Solidity当作一种类似于与区块链交互的编程语言。下面，正式认识一下Solidity。

Solidity 是一门面向对象的、为实现智能合约而创建的高级编程语言。这门语言受到了 C++，Python 和 Javascript 等语言的影响，设计的目的是能在以太坊虚拟机（EVM）上运行。还需要明确的是，Solidity 是静态类型语言，支持继承、库和复杂的用户定义类型等特性。

另外，在以太坊黄皮书中，也特意强调了Solidity是一门图灵完备的编程语言，图灵完备属于专业术语，简单理解就是支持循环和条件分支处理。因此，Solidity语言当中肯定可以使用循环和条件判断语句的，关于Solidity的语法特性，我们将在后面的内容展开。接下来，让我们来看看入门Solidity的智能合约。

下面的代码中，第一行的作用是为了控制智能合约编译器的版本，pragma就是Solidity的编译控制指令，`^0.6.10`代表的含义是可以使用0.6.x的版本对该代码进行编译，也就是说0.5.x或0.7.x的编译器版本不允许编译该智能合约，符号“^”代表向上兼容。也可以使用类似`pragma solidity >0.4.99 <0.6.0;`这样的写法来表达对编译器版本的限制，这样看上去也是非常的简单明了！

> 本教程中将以0.6.10作为基础版本介绍Solidity智能合约开发。

contract是一个关键字，用来定义合约名字，它很像是某些语言里的定义了一个类（class）。hello是本合约的名字，这个合约的主要功能是向区块链系统中存储一个Msg字符串。constructor是该合约的构造函数，它必须是public的（在Solc编译0.8.x版本后，constructor将不再允许声明为），当合约部署时，执行的也就是构造函数的逻辑，该构造函数的功能就是将Msg初始化为“hello”。

```solidity
pragma solidity^0.6.10;

contract hello {
    string public Msg;
    constructor() public {
        Msg = "hello world";
    }
}
```

下面，我们尝试在Remix环境部署该合约，并测试运行效果。打开[Remix在线IDE](http://remix.ethereum.org/)，我们将会看到如下的效果。

![image-20211209161648487](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhhk3ijj21910pbq5x.jpg)

这其中，左侧的【![image-20211209161852143](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhjrx40j200z00y0jq.jpg)】按钮是文件浏览器视图，【![image-20211209162029670](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhnhl63j200w00w0gb.jpg)】按钮是编译器视图，【![image-20211209162117125](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhgikagj200v00y0fs.jpg)】按钮是运行环境视图。

接下来，我们演示部署hello合约的操作流程。首先点击【![image-20211209161852143](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhjrx40j200z00y0jq.jpg)】按钮，打开浏览器视图，在contracts目录位置点击【右键】，在下拉表单中选择【New File】选项。

![image-20211209162852090](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhlqoo8j20m90hmjsp.jpg)

在输入框内容，输入智能合约文件的名字：hello.sol，如下图所示，然后回车创建文件成功。

![image-20211209163328868](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhkluwvj20n70hzjsr.jpg)



将之前的演示代码，粘贴到hello.sol文件中，并保存代码（Windows使用【ctrl+S】按键，macOS使用【command+S】按键），如下图所示。

![image-20211209163530043](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhmmo9vj20e508idg4.jpg)

若要切换编译器，可以点击【![image-20211209162029670](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhnhl63j200w00w0gb.jpg)】按钮，在COMPLIER下面的下拉表中选择对应的编译器版本，如下图所示。

![image-20211209163759541](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqheahsgj20sb0q5jul.jpg)

也可以在EVM版本位置选择某个特定版本，如下图所示。

![image-20211209164259421](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhiru8wj20sh0kpdhj.jpg)

默认情况后，保存代码后会自动编译，代码没有语法错误的话，就可以尝试运行了。点击【![image-20211209162117125](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhgikagj200v00y0fs.jpg)】按钮，可以切换到运行视图。如下图所示，点击【Deploy】按钮，便可以部署该合约。

![image-20211209164615881](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhf3i39j20t00k2ab9.jpg)

部署后，可以在下面的页面看到两部分信息，一个是合约对象，一个是运行信息，如下图所示。

![image-20211209164849500](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhg3uuwj218608tmy9.jpg)

点击合约对象前的【![image-20211209165027624](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhc4onpj200q00v0c1.jpg)】按钮，可以展开合约对象，如下图所示。之后，点击【Msg】按钮，可以看到hello world这个字符串内容。

![image-20211209165153174](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yqhofoanj20h90680sq.jpg)

这就是智能合约部署到测试的全部流程，不要认为这仅仅是一次字符串的打印，这背后其实涉及到了复杂的区块链技术，客户端将字节码签名后发送给节点，全网共识后，节点EVM中运行该字节码，记录下这样的字符串。

## 3 在以太坊测试网上部署你的智能合约

// TODO

##4 提交你的 Challenge!

// TODO
