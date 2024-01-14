// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.9.0/utils/math/SafeMath.sol";

contract RedeemDGN is ERC20, Ownable {
    using SafeMath for uint256;

    // Define an event for the redemption
    event Redeemed(address indexed account, string item, uint256 amount);

    // Mapping to store item prices
    mapping(string => uint256) public itemPrices;

    // Mapping to store user's items
    mapping(address => string) public userItems;

    constructor() ERC20("Degen", "DGN") {
        // Set initial item prices
        itemPrices["white"] = 12;
        itemPrices["black"] = 20;
        itemPrices["yellow"] = 14;
        itemPrices["green"] = 25;
    }

    function mint_DGN(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn_DGN(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Not enough funds");
        _burn(msg.sender, amount);
    }
    function redeemItem(string memory itemName) public payable{
        require(itemPrices[itemName] > 0, "Invalid item");
        require(balanceOf(msg.sender) >= itemPrices[itemName], "Not enough funds");
        _burn(msg.sender, itemPrices[itemName]);
        userItems[msg.sender] = itemName;
        emit Redeemed(msg.sender, itemName, itemPrices[itemName]);
    }

    function transfer_DGN(address _receiver, uint256 _value) external {
        require(_receiver != address(0), "Wrong Address");
        require(balanceOf(msg.sender) >= _value, "Not enough funds");
        _transfer(msg.sender, _receiver, _value);
    }

    function setItemPrice(string memory itemName, uint256 price) public onlyOwner {
        itemPrices[itemName] = price;
    }

    function getItemPrice(string memory itemName) public view returns (uint256) {
        return itemPrices[itemName];
    }

    function getUserItem(address userAddress) public view returns (string memory) {
        return userItems[userAddress];
    }

    function listAvailableItems() public view returns (string memory) {
        string memory itemList;
        for (uint256 i = 0; i < itemNames.length; i++) {
            string memory itemName = itemNames[i];
            uint256 itemPrice = itemPrices[itemName];
            string memory itemInfo = string(abi.encodePacked("[", itemName, "] Price: ", uint2str(itemPrice)));
            itemList = string(abi.encodePacked(itemList, itemInfo, " "));
        }
        return itemList;
    }

    function uint2str(uint256 _i) internal pure returns (string memory str) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        while (_i != 0) {
            k = k-1;
            uint8 ch = uint8(48 + _i % 10);
            bytes1 bch = bytes1(ch);
            bstr[k] = bch;
            _i /= 10;
        }
        str = string(bstr);
    }

    // Array to store item names for listing
    string[] public itemNames = ["white", "black","yellow", "green"];
}
