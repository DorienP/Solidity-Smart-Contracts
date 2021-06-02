pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet {
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }

    mapping(address => uint) allowance;


    function addAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }

    function reduceAllowance(address _who, uint _amount) internal ownedOrAllowed(_amount) {
        allowance[_who] -= _amount;
    }

    function ownedOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed!");
    }

    function withdrawMoney(address payable _to, uint _amount) public ownedOrAllowed(_amount) {
        require(_amount <= address(this).balance, "Contrat doesn't own enough money.");
        assert(allowance[msg.sender] >= allowance[msg.sender] - _amount);
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }

    receive() external payable {

    }


}