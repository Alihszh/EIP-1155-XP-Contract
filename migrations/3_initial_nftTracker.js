const Contract = artifacts.require("NFT_Tracker");

module.exports = function (deployer) {
  deployer.deploy(Contract);
};