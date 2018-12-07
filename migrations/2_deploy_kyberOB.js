var kyberOB = artifacts.require("./kyberOB.sol");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(kyberOB);
};