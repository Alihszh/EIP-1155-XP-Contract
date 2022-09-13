// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "./NFT_Tracker.sol";

contract XpToken is ERC1155, ERC1155Burnable {
    uint256 public constant XP = 0;
    address public accountZero = 0x55f58b0241728459aC1F26613d4EE6D439A9e7A2; //wallet which tokens dump at
    address public NFT_Tracker_Address; //nft_tracker address

    constructor() ERC1155("") {}

    function assign_xp(address to, uint256 amount) public onlyOwner {
        _mint(to, XP, amount, "");
    }

    function assign_xp_toNFT(
        address account,
        uint256 nftID,
        uint256 amount
    ) public onlyOwner {
        require(amount <= balance_xp(account), "XP amount exceeds balance");
        NFT_Tracker(NFT_Tracker_Address).xpToNFT(account, nftID, XP);
        transfer(account, amount);
    }

    function balance_xp(address account) public view returns (uint256 amount) {
        return balanceOf(account, XP);
    }

    function transfer(address account, uint256 amount) public onlyOwner {
        safeTransferFrom(account, accountZero, XP, amount, "");
    }

    ////////////////////////////////////////////THIS FUNCTION IS JUST FOR TEST PURPOSES
    function setAdress(address nft_tracker_address) public onlyOwner {
        NFT_Tracker_Address = nft_tracker_address;
    }
    //////////////////////////////////////////////////////////////////////////////////
}
