// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

import "./token/ERC721/ERC721.sol";

contract NFT is ERC721('NFT SC', 'NFT') {
    constructor() {
        _safeMint(msg.sender, 2100000000);
    }
}