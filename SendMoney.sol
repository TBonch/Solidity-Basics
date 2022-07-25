pragma solidity ^0.8.1;

contract SendMoney {
    uint public balanceReceived;
    uint public lockedUntil;

    // recives money from account onto smart contract
    function receiveMoney() public payable{
        balanceReceived += msg.value;
        lockedUntil = block.timestamp + 1 minutes;
    }

    // returns balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // withdraws money to the address that called the smart contract
    function withdrawMoney() public{
        if(lockedUntil < block.timestamp) {
            address payable to = payable(msg.sender);
            to.transfer(getBalance());
        }
    }
    // take a adress as paraemeter to send ether stored on smart contract
    function withdrawMoneyTo(address payable _to) public {
        if(lockedUntil < block.timestamp) 
            _to.transfer(getBalance());
    }

}