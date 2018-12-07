var relayer = artifacts.require("./relayer.sol");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(relayer);
};