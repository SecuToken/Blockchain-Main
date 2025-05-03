const SecuToken = artifacts.require("SecuToken");
 
module.exports = function (deployer) { 
  deployer.deploy(SecuToken); 
};
