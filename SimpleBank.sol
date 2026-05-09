// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleBank {
    address public owner;

    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    // Пополнение баланса
    function deposit() public payable {
        require(msg.value > 0, "Send ETH");

        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    // Проверка баланса
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }

    // Вывод ETH
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Not enough balance");

        balances[msg.sender] -= amount;

        payable(msg.sender).transfer(amount);

        emit Withdraw(msg.sender, amount);
    }

    // Баланс контракта
    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
