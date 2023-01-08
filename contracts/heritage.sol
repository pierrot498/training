// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./EIP712.sol";

// This is just a simple example heritage smart contract

contract heritage is EIP712 {

	
	mapping (address =>mapping ( address => uint)) balances; // User of this token
	mapping (address => address) emergency; // User of this token

	event Claim(address indexed _from, address indexed _to, uint256 _value);
	event Deposit(address indexed _from, address indexed _token, uint256 _value);
	



	function deposit(address _token,uint256 _amount) external {
		require(IERC20(_token).balanceOf(msg.sender)>=_amount,"Not enought balance for this token");
		IERC20(_token).transferFrom(msg.sender,address(this),_amount);
		balances[msg.sender][_token]+=_amount;
		emit Deposit(msg.sender,_token,_amount);
    }

	function setEmergency(address _user) external {
		emergency[msg.sender] = _user;
	}

    function claim(Voucher memory voucher, uint8 v, bytes32 r, bytes32 s) external {
		address owner = verif(voucher, v, r, s);
		require(balances[owner][voucher.token]>=voucher.amount,"Wrong amount of token");
        require(voucher.amount > 0, "Wrong amount");
        require(emergency[owner] == msg.sender, "Wrong emergency account");
		//require(nonce[owner]==voucher.nonce, "Wrong nonce");

		IERC20(voucher.token).transfer(msg.sender,voucher.amount);
		balances[owner][voucher.token]-=voucher.amount;
        emit Claim(owner,msg.sender,voucher.amount);
    }

    
}
