// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Bank {
    mapping(address => uint256) public balances;

    event Deposit(address account, uint256 amount);
    event Withdrawal(address account, uint256 amount);

    function causeError(uint256 _value) public pure {
        if (_value <= 0) {
            revert("Transaction value cannot be less than or equal to zero");
        }
    }
    function deposit() external payable {
        causeError(msg.value); 

        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }


    function withdraw(uint256 _amount) external {
    causeError(_amount);

    assert(balances[msg.sender] >= _amount); 

    balances[msg.sender] -= _amount;
    payable(msg.sender).transfer(_amount);
    emit Withdrawal(msg.sender, _amount);
    }


    function checkBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
