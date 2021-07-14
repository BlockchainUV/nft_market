// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

import "./token/ERC721/ERC721.sol";

contract Market is ERC721('Marketplace', 'MKT') {
    address _marketOwner;
    
    uint256 public tokenCounter;
    uint256 _tokedIdIndex;

    constructor() {
        _marketOwner = msg.sender;

        tokenCounter = 1;
        _tokedIdIndex = 1000000;

        _safeMint(msg.sender, _tokedIdIndex);
    }

    function create() public {
        require(_marketOwner == msg.sender, "Request not from owner of the contract.");

        _tokedIdIndex += 1;
        
        _safeMint(msg.sender, _tokedIdIndex);
        
        tokenCounter += 1;
    }

    function mktOwnerOf() public view returns (address) {
        return _marketOwner;
    }

    function buy(uint256 tokenId) public {
        require(_exists(tokenId), "TokenId does not exist.");

        address _tokenIdOwner = ownerOf(tokenId);
        
        _transfer(_tokenIdOwner, msg.sender, tokenId);
    }

    function sell(uint256 tokenId, address to) public {
        require(_exists(tokenId), "TokenId does not exist.");
        
        address _tokenIdOwner = ownerOf(tokenId);
        
        require(_tokenIdOwner == msg.sender, "Request not from tokenId owner.");
        
        _transfer(msg.sender, to, tokenId);
    }
}