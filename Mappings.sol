pragma solidity ^0.8.4;

contract SimpleMappingExample {
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;
    mapping (uint => mapping(uint => bool)) uintUintBoolMapping;


    function setuintUintBoolMapping(uint _index1, uint _index2, bool _value) public {
        setuintUintBoolMapping[_index1][_index2] = _value;
    }
    function getuintUintBoolMapping(uint _index1, uint _index2) public view returns(bool){
        return uintUintBoolMapping[_index1][_index2];
    }

    function setValue(uint _index) public {
        myMapping[_index] = true;
    }
    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
}