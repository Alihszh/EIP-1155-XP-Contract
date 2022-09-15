// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "./nft_explorer.sol";

contract XpToken is Ownable, ERC1155, ERC1155Burnable {
    using Counters for Counters.Counter;

    Counters.Counter private _counter;
    uint256 public constant XP = 0;
    address public _accountZero = 0x55f58b0241728459aC1F26613d4EE6D439A9e7A2; //wallet which tokens dump at
    address public _nftExplorerAddress; //nft_explorer address

    constructor() ERC1155("") {}

    struct info {
        address from;
        uint16 G_code;
        uint16 B_code;
        uint256 xp;
    }

    mapping(uint256 => info) public history;

    function assign_xp(address to, uint256 amount, uint16 g_code) public onlyOwner {
        if(_mint(to, XP, amount, "")){
            history[_counter.current()].xp = amount;
            history[_counter.current()].from = to;
            history[_counter.current()].G_code = g_code;
        }


    }

    function assign_xp_toNFT(
        address from,
        uint256 nftID,
        uint256 amount
    ) public {
        require(amount <= balance_xp(from), "XP amount exceeds balance");
        if (nft_explorer(_nftExplorerAddress).xpToNFT(from, nftID, amount)) {
            transfer(from, amount);
        }
    }

    function balance_xp(address account) public view returns (uint256 amount) {
        return balanceOf(account, XP);
    }

    function transfer(address account, uint256 amount) public {
        safeTransferFrom(account, _accountZero, XP, amount, "");
    }

    ////////////////////////////////////////////THIS FUNCTION IS JUST FOR TEST PURPOSES
    function setAdress(address nft_tracker_address) public onlyOwner {
        _nftExplorerAddress = nft_tracker_address;
    }
    //////////////////////////////////////////////////////////////////////////////////
}
