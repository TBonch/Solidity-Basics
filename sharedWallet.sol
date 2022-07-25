pragma solidity 0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable{

    event AllowanceChange(address indexed _recipient, address indexed _sender, uint _oldBalance, uint _newBalance);
    //Function to view who owner is
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
    mapping(address => uint) allowanceBalance;


    //modifier to only allow owner or allowance with a balance to withdraw
    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowanceBalance[msg.sender] >= _amount, "You are not allowed!");
        _;
    }
    //allowance is added to the smart contract and stored in map [user/amount]
    function setAllowance(address _user, uint _amount) public onlyOwner {
        emit AllowanceChange(_user, msg.sender, allowanceBalance[_user], _amount);
        allowanceBalance[_user] = _amount;
        
    }
    //reduce allowance from the user when amount is withdrawn
    function reduceAllowance(address _user, uint _amount) internal ownerOrAllowed(_amount) {
        emit AllowanceChange(_user, msg.sender, allowanceBalance[_user], _amount);
        allowanceBalance[_user] -= _amount; 
    }
}
    
    // created seperate contratcs to clean up the code
    contract SharedWallet is Allowance{

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    event MoneyWithdrawn(address _from, address _to, uint _amount);
    
    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount){
        require(_amount <= address(this).balance, "not enough money on this contract");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    //fallback function 
    receive() external payable{
        emit MoneyReceived(msg.sender, msg.value);
    }
}