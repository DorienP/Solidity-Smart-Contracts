pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet {

    mapping(address => uint) addressBalance;

    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
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