// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "./nft_explorer.sol";

contract XpToken is Ownable, ERC1155, ERC1155Burnable {
    uint256 public constant XP = 0;
    address public _accountZero = 0x55f58b0241728459aC1F26613d4EE6D439A9e7A2; //wallet which tokens dump at
    address public _nftExplorerAddress; //nft_explorer address

    constructor() ERC1155("") {}

    struct InfoXP {
        uint16 G_code;
        uint16 B_code;
        uint256 counter;
        uint256 XpNumber;
    }

    struct burnedXP {
        address from;
        uint16 G_code;
        uint256 date;
    }

    mapping(address => InfoXP[]) public history;

    function getXpDetails(address account)
        public
        view
        returns (InfoXP[] memory)
    {
        InfoXP[] memory list = history[account];
        return list;
    }

    burnedXP[] burnHistory;

    function assign_xp(
        address to,
        uint256 amount,
        uint16 g_code
    ) public onlyOwner {
        if (_mint(to, XP, amount, "")) {
            history[to].push(InfoXP(g_code, 0, 0, amount));
        }
    }

    function assign_xp_toNFT(
        address from,
        uint256 nftID,
        uint256 amount
    ) public {
        require(amount <= balance_xp(from), "XP amount exceeds balance");
        if (nft_explorer(_nftExplorerAddress).xpToNFT(from, nftID, amount)) {
            transfer(from, amount, 9999);
        }
    }

    function balance_xp(address account) public view returns (uint256 amount) {
        return balanceOf(account, XP);
    }

    function transfer(
        address from,
        uint256 amount,
        uint16 b_code
    ) public {
        require(
            from == _msgSender(),
            "ERC1155: caller is not token owner nor approved"
        );
        if (balanceOf(from, XP) >= amount) {
            safeTransferFrom(from, _accountZero, XP, amount, "");
            uint256 count = history[from][0].counter;
            for (uint256 i = 0; i < amount; i++) {
                history[from][count].B_code = b_code;
                count++;
                history[from][0].counter = count;
                burnHistory.push(burnedXP(from, b_code, block.timestamp));
            }
        }
    }

    function getXpOwner(uint256 index)
        public
        view
        returns (
            address,
            uint16,
            uint256
        )
    {
        address wallet = burnHistory[index].from;
        uint16 g_code = burnHistory[index].G_code;
        uint256 time = burnHistory[index].date;
        return (wallet, g_code, time);
    }

    ////////////////////////////////////////////THIS FUNCTION IS JUST FOR TEST PURPOSES
    function setAdress(address nft_tracker_address) public onlyOwner {
        _nftExplorerAddress = nft_tracker_address;
    }
    //////////////////////////////////////////////////////////////////////////////////
}
