// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/access/Ownable.sol";

contract MToken is ERC20, Ownable {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // Mint 100 tokens to msg.sender
        // 1 token = 1 * (10 ** decimals())
        _mint(msg.sender, 100 * 10 ** decimals());
    }

    // Mint function to create new tokens
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Burn function to destroy tokens
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Burn function to destroy tokens from a specified address
    function burnFrom(address account, uint256 amount) public {
        uint256 currentAllowance = allowance(account, msg.sender);
        require(currentAllowance >= amount, "ERC20: burn amount exceeds allowance");
        _approve(account, msg.sender, currentAllowance - amount);
        _burn(account, amount);
    }

    // Function to check balance of any address
    function getBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }
}
