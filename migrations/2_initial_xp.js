const Contract = artifacts.require("XpToken");

module.exports = function (deployer) {
  deployer.deploy(Contract);
};