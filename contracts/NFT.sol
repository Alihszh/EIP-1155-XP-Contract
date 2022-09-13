// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./NFT_Tracker.sol";

contract NFT is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    address public NFT_Tracker_Address; //nft_tracker address

    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(address to, string memory uri) public onlyOwner {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        NFT_Tracker(NFT_Tracker_Address).mapNFT(to, 85);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    /////////////////////////////////////////////THIS FUNCTION IS JUST FOR TEST PURPOSES
    function setAdress(address nft_tracker_address) public onlyOwner {
        NFT_Tracker_Address = nft_tracker_address;
    }
    ////////////////////////////////////////////////////////////////////////////////////
}
