// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract nft_explorer is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _nftID;

    mapping(uint256 => mapping(address => uint256)) public owners;

    constructor() ERC721("", "") {}

    function mapNFT(address account, uint256 XP) external {
        owners[_nftID.current()][account] = XP;
        _nftID.increment();
    }

    function xpToNFT(
        address account,
        uint256 nftID,
        uint256 XP
    ) external returns (bool) {
        require(msg.sender == ownerOf(nftID), "Your are not NFT owner");
        owners[nftID][account] += XP;
        return true;
    }

    function XpAmount(uint256 nftID, address account)
        public
        view
        returns (uint256)
    {
        return owners[nftID][account];
    }
}
