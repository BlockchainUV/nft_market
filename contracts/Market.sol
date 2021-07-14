// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

import "./token/ERC721/ERC721.sol";
import "./Token.sol";

contract Market is ERC721('Marketplace', 'MKT') {
    Token _token;

    address _marketOwner;
    
    uint256 public tokenCounter;
    uint256 _tokedIdIndex;

    mapping(uint256 => uint256) _price;

    constructor(address token_, uint256 price_) {
        _token = Token(token_);

        tokenCounter = 1;
        _tokedIdIndex = 1000000;

        _marketOwner = msg.sender;
        _price[_tokedIdIndex] = price_;

        _safeMint(msg.sender, _tokedIdIndex);
    }

    function mktOwnerOf() public view returns (address) {
        return _marketOwner;
    }

    function tokenPrice(uint tokenId) public view returns (uint256) {
        return _price[tokenId];
    }

    function accountBal(address account) public view returns (uint256) {
        return _token.balanceOf(account);
    }

    function transferToken(address recipient, uint256 amount) public returns (bool) {
        return _token.transfer(recipient, amount);
    }

    function create(uint256 price_) public {
        //require(_marketOwner == msg.sender, "Request not from owner of the contract.");

        _tokedIdIndex += 1;
        _price[_tokedIdIndex] = price_;
        
        _safeMint(msg.sender, _tokedIdIndex);
        
        tokenCounter += 1;
    }

    function buy(uint256 tokenId) public {
        require(_exists(tokenId), "TokenId does not exist.");
        
        address _tokenIdOwner = ownerOf(tokenId);
        
        require(_token.balanceOf(_tokenIdOwner) >= _price[tokenId], "Insufficient balance in account.");

        _transfer(_tokenIdOwner, msg.sender, tokenId);
        _token.transfer(_tokenIdOwner, _price[tokenId]);
    }

    function sell(uint256 tokenId, address to) public {
        require(_exists(tokenId), "TokenId does not exist.");
        
        address _tokenIdOwner = ownerOf(tokenId);
        
        require(_tokenIdOwner == msg.sender, "Request not from tokenId owner.");
        require(_token.balanceOf(to) >= _price[tokenId], "Insufficient balance in account.");
        
        _transfer(msg.sender, to, tokenId);

        // Need help...
        // the below command does not seem to tranfer tokens from 'to' address as required.
        // not sure how to do it.

        _token.transfer(_tokenIdOwner, _price[tokenId]);
    }
}