// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract XpToken is ERC1155, ERC1155Burnable, Ownable {
    uint256 public constant XP = 0;

    constructor() ERC1155("") {}

    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, XP, amount, "");
    }

    function transferXP(address to, uint256 amount) public onlyOwner {
        _safeTransferFrom(msg.sender, to, XP, amount, "");
    }

    function XP_Balance(address account) public view returns (uint256 amount) {
        return balanceOf(account, XP);
    }

    function burn_XP(address account, uint256 amount) public onlyOwner {
        _burn(account, XP, amount);
    }
}
