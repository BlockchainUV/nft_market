const Token = artifacts.require("Token");
const NFT = artifacts.require("NFT");
const Market = artifacts.require("Market");

module.exports = function(deployer) {
    deployer.deploy(Token);
    deployer.deploy(NFT);
    deployer.deploy(Market);
}