pragma solidity ^0.4.18;

import "../lib/DelegateProxy.sol";
import "./Storage.sol";


contract RootChainProxy is Storage, DelegateProxy {
  // Function naming service 
  mapping(bytes4 => address) public FNS;
  // constructor() {
  // }

  function addFunction(bytes4 _sig, address _address) public { // onlyowner
    FNS[_sig] = _address;
  }

  function () public payable {
    require(FNS[msg.sig] != address(0x0), "Unknown function");
    
    delegatedFwd(FNS[msg.sig], msg.data);
  }
}