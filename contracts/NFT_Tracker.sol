// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT_Tracker is ERC721{

    mapping(uint256 => address) private owners;

    constructor () ERC721("",""){}

    function OwnerOf(uint256 tokenId) public view returns (address) {
        return ownerOf(tokenId);
    }

}