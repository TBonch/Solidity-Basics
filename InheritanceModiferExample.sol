pragma solidity ^0.5.11;

// contract Owned {
//     address owner;

//     constructor() public {
//         owner = msg.sender;
//  }

//  modifier onlyOwner {
//     require(msg.sender == owner, "You are not allowed");
//     _;
//  }
// }

import "./Owned.sol";

//inheritance linked using 'is' --> contract name

contract InheritanceModifierExample is Owned {

 mapping(address => uint) public tokenBalance;


 uint tokenPrice = 1 ether;

 constructor() public {
    tokenBalance[owner] = 100;
 }
 //modifier 
 modifier onlyOwner {
    require(msg.sender == owner, "You are not allowed");
    _;
 }
    //using view function to view state vars, cost nothing
 function getOwner() public view returns(address) {
    return owner;
    }
 function createNewToken() public onlyOwner {
    require(msg.sender == owner, "You are not allowed");
    tokenBalance[owner]++;
 }

 function burnToken() public onlyOwner {
    require(msg.sender == owner, "You are not allowed");
    tokenBalance[owner]--;
 }

 function purchaseToken() public payable {
    require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
    tokenBalance[owner] -= msg.value / tokenPrice;
    tokenBalance[msg.sender] += msg.value / tokenPrice;
 }

 function sendToken(address _to, uint _amount) public {
    require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
    assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
    assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);

    tokenBalance[msg.sender] -= _amount;
    tokenBalance[_to] += _amount;
 }

}