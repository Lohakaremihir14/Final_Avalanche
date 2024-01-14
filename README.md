## Project: Degen Token ##
This Solidity contract implements a basic ERC20 token named Degen Token. In this project it also includes additional functionalities for redeem , list the items and pricing of those items.

## Outline of the Project ##
The contract extends the ERC20 and Ownable contracts from the OpenZeppelin library.
It defines events, mappings, and functions to manage tokens and items.

## Functions of the Code ##
mint_DGN: Allows the owner to mint new tokens and distribute them to a specified address.
burn_DGN: Allows users to burn their own tokens.
redeemItem: Allows users to redeem an item by providing the item name and paying the corresponding price in tokens.
transfer_DGN: Allows users to transfer tokens to another address.
setItemPrice: Allows the owner to set or update the price of an item.
getItemPrice: Retrieves the price of a specific item.
getUserItem: Retrieves the item owned by a specific user.
listAvailableItems: Lists all available items along with their prices.

## Implementation ##
Deploy the contract on an Ethereum-compatible blockchain.
Use a wallet or script to interact with the contract's functions.

## Example ##
Item Prices

```
 constructor() ERC20("Degen", "DGN") {
        // Set initial item prices
        itemPrices["white"] = 12;
        itemPrices["black"] = 20;
        itemPrices["yellow"] = 14;
        itemPrices["green"] = 25;
    }

// For redeem the list items 
function redeemItem(string memory itemName) public payable
{
        require(itemPrices[itemName] > 0, "Invalid item");
        require(balanceOf(msg.sender) >= itemPrices[itemName], "Not enough funds");
        _burn(msg.sender, itemPrices[itemName]);
        userItems[msg.sender] = itemName;
        emit Redeemed(msg.sender, itemName, itemPrices[itemName]);
        }
```

## Author ##
Mihir Lohakare 

## License ##
This project is licensed under the [MIT] License - see the LICENSE.md file for details
