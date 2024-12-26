// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "./ERC20.sol";

contract USDTToken is ERC20 {
    address private _owner;

    constructor() ERC20("Tether USD", "USDT", 6){
        _owner = msg.sender;
    }

    function airdrop(address to) public virtual returns (bool) {
        uint256 max = 10000;
        uint256 mul = 10;
        for (uint i = 0; i < decimals(); i++) {
            max = max * mul;
        }
        if (balanceOf(to) < max) {
            _mint(to, max - balanceOf(to));
        }
        return true;
    }

    function mint(uint256 value) public virtual returns (bool) {
        address to = msg.sender;
        require(to == _owner, 'invalid operate');
        _mint(to, value);
        return true;
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    function changeOwner(address to) public virtual returns (bool) {
        require(to == _owner, 'invalid operate');
        _owner = to;
        return true;
    }
}
