const nft_explorer = artifacts.require("nft_explorer");

module.exports = function (deployer) {
  deployer.deploy(nft_explorer);
};