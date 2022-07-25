pragma solidity ^0.8.4;

contract MappingStructExample{

    struct Payment {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balanceReceived;
    
    //voews balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    //sends money to smart contract
     function sendMoney() public payable {
         balanceReceived[msg.sender].totalBalance += msg.value;

        Payment memory payment = Payment(msg.value, block.timestamp);
        // th e payments mapping is used to store the number of payments from sender
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
        //numnpayments is used as opayment counter
        balanceReceived[msg.sender].numPayments++;
     }

    function withdrawMoney(address payable _to, uint _amount) public {
        // checks to make sure cannot withdraw balance <= recieved of total balance from sender
        require(_amount <= balanceReceived[msg.sender].totalBalance, "not enough funds");
        // subracts total balance balanced recieved from amount
        balanceReceived[msg.sender].totalBalance -= _amount;
        //transfers amount
        _to.transfer(_amount);
    }
    //withdraws money stored in contract to account
    function withdrawAllMoney(address payable _to) public {
        // total balance received from sender.
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
    }

}

