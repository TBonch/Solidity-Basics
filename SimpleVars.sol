pragma solidity ^0.8.1;

contract workingWithVariables {
    uint public myUint;

    //unsinged intergers
    function setMyunit(uint _myUnit) public {
        myUint = _myUnit;
    }

    // Boolean
    bool public mybool;
    function setMyBool(bool _mybool) public {
        mybool = _mybool;
    }

    //overflow and underflow
    uint8 public myUint8;

    function decrement() public {
        unchecked {
            myUint8--;
        }
    }
    function increment() public{
        unchecked {
            myUint8++;
        }
    }

    // Address
    address public myAddress;
    function setAddress(address _address) public {
        myAddress = _address;
    }
    function getBalancesOfAccount() public view returns(uint) {
        return myAddress.balance;
    }

    // Strings
    string public myString = 'Hello World';
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
}