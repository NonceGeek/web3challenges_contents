
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 定义接口
interface EvidenceSignersDataABI
{
	function verify(address addr) external view returns(bool);
	function getSigner(uint index) external view returns(address);
	function getSignersSize() external view returns(uint);
}

// 执行入口
contract EvidenceFactory is EvidenceSignersDataABI {
        address[] signers;
		event newEvidenceEvent(address addr);
        
        function newEvidence(string memory evi) public returns(address)
        {
            Evidence evidence = new Evidence(evi, address(this));
            emit newEvidenceEvent(address(evidence));
            return address(evidence);
        }
        
        function getEvidence(address addr) public view returns(string memory, address[] memory, address[] memory){
            return Evidence(addr).getEvidence();
        }

                
        function addSignatures(address addr) public returns(bool) {
            return Evidence(addr).addSignatures();
        }
        
        constructor(address[] memory evidenceSigners){
            for(uint i=0; i<evidenceSigners.length; ++i) {
                signers.push(evidenceSigners[i]);
			}
		}

        function verify(address addr) external override view returns(bool){
                for(uint i=0; i<signers.length; ++i) {
                if (addr == signers[i])
                {
                    return true;
                }
            }
            return false;
        }

        function getSigner(uint index)external override view returns(address){
            uint listSize = signers.length;
            if(index < listSize)
            {
                return signers[index];
            }
            else
            {
                return address(0);
            }
    
        }

        function getSignersSize() external override view returns(uint){
            return signers.length;
        }
    
        function getSigners() public view returns(address[] memory){
            return signers;
        }

}

contract Evidence{
    
    string evidence; // 存证信息
    address[] signers; // 多签账户
    address public factoryAddr; // 工厂合约地址
    
    event addSignaturesEvent(string evi);
    event newSignaturesEvent(string evi, address addr);
    event errorNewSignaturesEvent(string evi, address addr);
    event errorAddSignaturesEvent(string evi, address addr);
    event addRepeatSignaturesEvent(string evi);
    event errorRepeatSignaturesEvent(string evi, address addr);

    function CallVerify(address addr) public view returns(bool) {
        return EvidenceSignersDataABI(factoryAddr).verify(addr);
    }

   constructor(string memory evi, address addr)  {
       factoryAddr = addr;
       // tx.origin 原始调用账户 
       if(CallVerify(tx.origin))
       {
           evidence = evi;
           signers.push(tx.origin);
           emit newSignaturesEvent(evi,addr);
       }
       else
       {
           emit errorNewSignaturesEvent(evi,addr);
       }
    }
    // 查询存证：存证信息，待签名列表，已签名列表
    function getEvidence() public view returns(string memory, address[] memory, address[] memory){
        uint length = EvidenceSignersDataABI(factoryAddr).getSignersSize();
         address[] memory signerList = new address[](length);
         for(uint i= 0 ;i<length ;i++)
         {
             signerList[i] = (EvidenceSignersDataABI(factoryAddr).getSigner(i));
         }
        return(evidence, signerList, signers);
    }
    // 添加签名
    function addSignatures() public returns(bool) {
        for(uint i= 0 ;i<signers.length ;i++)
        {
            if(tx.origin == signers[i])
            {
                emit addRepeatSignaturesEvent(evidence);
                return true;
            }
        }
       if(CallVerify(tx.origin))
       {
            signers.push(tx.origin);
            emit addSignaturesEvent(evidence);
            return true;
       }
       else
       {
           emit errorAddSignaturesEvent(evidence,tx.origin);
           return false;
       }
    }
    // 返回待签名列表
    function getSigners()public view returns(address[] memory)
    {
         uint length = EvidenceSignersDataABI(factoryAddr).getSignersSize();
         address[] memory signerList = new address[](length);
         for(uint i= 0 ;i<length ;i++)
         {
             signerList[i] = (EvidenceSignersDataABI(factoryAddr).getSigner(i));
         }
         return signerList;
    }
}