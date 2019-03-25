pragma solidity ^0.4.24;

import { ERC20 } from "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import { Math } from "openzeppelin-solidity/contracts/math/Math.sol";

import { RLP } from "../lib/RLP.sol";
import { Merkle } from "../lib/Merkle.sol";
import { PriorityQueue } from "../lib/PriorityQueue.sol";
import { ExitNFT } from "../token/ExitNFT.sol";
import { WETH } from "../token/WETH.sol";
import { RootChainable } from "../mixin/RootChainable.sol";

import { IRootChain } from "./IRootChain.sol";
import { DepositManager } from "./DepositManager.sol";

contract Storage {
//   using SafeMath for uint256;
  using RLP for bytes;
  using RLP for RLP.RLPItem;
  using RLP for RLP.Iterator;
  
  struct HeaderBlock {
    bytes32 root;
    uint256 start;
    uint256 end;
    uint256 createdAt;
    address proposer;
  }

  // structure for plasma exit
  struct PlasmaExit {
    address owner;
    address token;
    uint256 amountOrTokenId;
    bool burnt;
  }

  // deposit block
  struct DepositBlock {
    uint256 header;
    address owner;
    address token;
    uint256 amountOrTokenId; // needs better name
    uint256 createdAt;
  }

  mapping(address => bool) public proofValidatorContracts;

  // child chain contract
  address public childChainContract;

  // list of header blocks (address => header block object)
  mapping(uint256 => HeaderBlock) public headerBlocks;

  // current header block number
  uint256 internal _currentHeaderBlock;


  // stake interface
//   StakeManager public stakeManager;
  
  // withdraw manager
//   WithdrawManager public withdrawManager;

  // deposit manager
//   DepositManager public depositManager;
    // mapping for (root token => child token)
  mapping(address => address) public tokens;

  // mapping for (child token => root token)
  mapping(address => address) public reverseTokens;

  // mapping whether a token is erc721 or not
  mapping(address => bool) public isERC721;

  // weth token
//   address public wethToken;

  DepositManager public depositManager;

  // all plasma exits
  mapping (uint256 => PlasmaExit) public exits;

  // mapping with token => (owner => exitId) keccak(token+owner) keccak(token+owner+tokenId)
  mapping (bytes32 => uint256) public ownerExits;


  // exit queue for each token
  mapping (address => address) public exitsQueues;

  // exit NFT contract
  address public exitNFTContract;

  // WETH address
  address public wethToken;



  // list of deposits
  mapping(uint256 => DepositBlock) public deposits;

  // current deposit count
  uint256 public depositCount;

}