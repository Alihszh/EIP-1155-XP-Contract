// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract XpToken is ERC1155, ERC1155Burnable, Ownable {
    uint256 public constant XP = 0;

    mapping(address => uint256) NFT_XP;

    constructor() ERC1155("") {}

    function assign_xp(address to, uint256 amount) public onlyOwner {
        _mint(to, XP, amount, "");
    }

    function assign_xp_toNFT(address account, address nftID, uint256 amount) public onlyOwner {
        require(amount <= balance_xp(account) , "XP amount exceeds balance");
        NFT_XP[nftID] += amount;
        _burn(account, XP, amount);
    }

    function balance_xp(address account) public view returns (uint256 amount) {
        return balanceOf(account, XP);
    }

    function burn_xp(address account, uint256 amount, uint256 flag) public onlyOwner {
        if(flag==1){
            NFT_XP[account] +=amount;
        }
        _burn(account, XP, amount);
    }
}
