pragma solidity ^0.8.1;

contract StartStopUpdateExample {

    address public owner;

    // called once during deployment
    constructor(){
        owner = msg.sender
    }

    function sendMoney() public payable {

    }

    function withdrawAllMoney(address payable _to) public {
        _to.transfer(address(this).balance);
    }
}