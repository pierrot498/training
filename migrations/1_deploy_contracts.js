const Heritage = artifacts.require("Heritage");
const Toekn = artifacts.require("Token");

module.exports = function(deployer) {
  deployer.deploy(Heritage);
  deployer.deploy(Token);
};
