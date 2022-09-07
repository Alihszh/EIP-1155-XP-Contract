// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract XpToken is ERC1155, ERC1155Burnable, Ownable {
    uint256 public constant XP = 0;
    address public accountZero;

    mapping(address => uint256) NFT_XP; //This value should be in NFT_Tracker and then that contract should work with this one usign proxy

    constructor() ERC1155("") {}

    function assign_xp(address to, uint256 amount) public onlyOwner {
        _mint(to, XP, amount, "");
    }

    function assign_xp_toNFT(
        address account,
        address nftID,
        uint256 amount
    ) public onlyOwner {
        require(amount <= balance_xp(account), "XP amount exceeds balance");
        NFT_XP[nftID] += amount;
        transfer(account, amount);
    }

    function balance_xp(address account) public view returns (uint256 amount) {
        return balanceOf(account, XP);
    }

    function transfer(address account, uint256 amount) public onlyOwner {
        safeTransferFrom(account, accountZero, XP, amount, ""); //Modify safeTransfer in a way so can only owner can do it.
    }
}
