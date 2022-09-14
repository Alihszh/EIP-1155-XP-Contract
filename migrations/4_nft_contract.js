const nft = artifacts.require("nft");

module.exports = function (deployer) {
  deployer.deploy(nft);
};
