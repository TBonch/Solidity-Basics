pragma solidity ^0.5.11;

contract EventExample {
    mapping(address => uint) public tokenBalance;

    event TokenSent(address _from, address _to, uint _amount);

    //owner of smart contract has 100 tokens on deployment
    constructor() public{
        tokenBalance[msg.sender] = 100;
    }

    function sendToken(address _to, uint _amount) public returns(bool){
        require(tokenBalance[msg.sender] >= _amount, "not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);

        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        emit TokenSent(msg.sender, _to, _amount);

        return true;
    }


}