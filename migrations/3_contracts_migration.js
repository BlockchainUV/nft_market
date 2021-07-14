const Market = artifacts.require("Market");

module.exports = function(deployer) {
    deployer.deploy(Market, '0x801Aff15DcC82163e3E38dA3Aec2E750A3665f2f', 100);
}