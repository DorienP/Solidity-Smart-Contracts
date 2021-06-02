pragma solidity ^0.8.4;

contract SharedWallet {

    address payable owner;

    mapping(address => uint) addressBalance;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner.");
        _;
    }

    function depositMoney() public payable {
        addressBalance[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        require(addressBalance[msg.sender] >= _amount, "Not enough Funds.");
        assert(addressBalance[msg.sender] >= addressBalance[msg.sender] - _amount);
        addressBalance[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    receive() external payable {

    }


}