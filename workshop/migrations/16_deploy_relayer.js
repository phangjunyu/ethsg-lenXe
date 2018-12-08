/* global artifacts */
/* eslint-disable no-unused-vars */
const NetworkProxy = artifacts.require('./KyberNetworkProxy.sol');

const Relayer = artifacts.require('./ethSG/relayer.sol')

module.exports = async (deployer, network, accounts) => {
  const admin = accounts[0];

  await deployer.deploy(Relayer, NetworkProxy.address);
};
