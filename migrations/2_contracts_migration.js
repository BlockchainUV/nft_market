const Token = artifacts.require("Token");
const NFT = artifacts.require("NFT");

module.exports = function(deployer) {
    deployer.deploy(Token);
    deployer.deploy(NFT);
}