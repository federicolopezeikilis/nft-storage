// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BAYCMock is ERC721 {
    uint256 public MAX_AMOUNT_PER_USER;
    uint256 public tokenCounter;
    mapping(address => uint256) internal nftsStored; 

    constructor() ERC721("BAYCMock", "<3") {
        MAX_AMOUNT_PER_USER = 3;
        tokenCounter = 0;
    }

    function availableToMint(address _address) public view returns (uint256) {
        return MAX_AMOUNT_PER_USER - nftsStored[_address];
    }

    function mint(uint256 amount) public {
        uint256 availableNfts = availableToMint(msg.sender);

        require(availableNfts > 0, "no more nfts available for you");
        require(amount <= availableNfts, "you cannot mint too much");

        for(uint256 i = amount; i > 0; i--) {
            _safeMint(msg.sender, tokenCounter);
            tokenCounter++;
        }

        nftsStored[msg.sender] += amount; 
    }
}