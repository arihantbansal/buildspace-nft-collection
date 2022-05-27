// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string baseSVG =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] firstWords = [
        "Epic",
        "Hypnotic",
        "Disturbed",
        "Profuse",
        "Awake",
        "Energetic",
        "Desperate",
        "Impartial",
        "Naive",
        "Dusty",
        "Free",
        "Whole",
        "Scientific",
        "Disastrous",
        "Lopsided"
    ];
    string[] secondWords = [
        "Cupcake",
        "Pizza",
        "Milkshake",
        "Salad",
        "Sandwich",
        "Curry",
        "Pie",
        "Roll",
        "Yogurt",
        "Coconut",
        "Chocolate",
        "Mango",
        "Wine",
        "Pastry",
        "Donut"
    ];
    string[] thirdWords = [
        "Apollo",
        "Poseidon",
        "Zeus",
        "Aphrodite",
        "Hera",
        "Hades",
        "Hermes",
        "Demeter",
        "Athena",
        "Artemis",
        "Ares",
        "Iris",
        "Dionysus",
        "Hephaestus",
        "Hestia"
    ];

    constructor() ERC721("NFTywords", "W0RDZ") {
        console.log("did ya ask for nfts with some words? i heard ya callin'");
    }

    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        string memory first = pickRandomFirstWord(tokenId);
        string memory second = pickRandomSecondWord(tokenId);
        string memory third = pickRandomThirdWord(tokenId);

        string memory finalSVG = string(
            abi.encodePacked(baseSVG, first, second, third, "</text></svg>")
        );

        console.log("\n--------------------");
        console.log(finalSVG);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);

        _setTokenURI(newItemId, "blah");

        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        _tokenIds.increment();
    }
}
