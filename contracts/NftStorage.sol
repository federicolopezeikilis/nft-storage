// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract NftStorage {
    mapping(address => mapping(uint256 => address)) public ownerOf;

    function depositNft(address collection, uint256 tokenId) public {
        IERC721 nft = IERC721(collection);

        require(nft.ownerOf(tokenId) == msg.sender, "sender is not the owner of the nft");

        nft.transferFrom(msg.sender, address(this), tokenId);

        ownerOf[collection][tokenId] = msg.sender; 
    }

    function withdrawNft(address collection, uint256 tokenId) public {
        require(ownerOf[collection][tokenId] == msg.sender, "sender is not the owner of the nft");

        IERC721 nft = IERC721(collection);

        nft.transferFrom(address(this), msg.sender, tokenId);

        delete ownerOf[collection][tokenId];
    }
}