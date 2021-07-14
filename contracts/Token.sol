// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

import "./token/ERC20/ERC20.sol";

contract Token is ERC20('Token', 'TKN') {
    constructor() {
        _mint(msg.sender, 2100000000);
    }
}