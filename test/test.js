//const Heritage = artifacts.require("heritage");
const Token = artifacts.require("Token");

const DEMO_TYPES = {
    EIP712: [
        {
            type: "address",
            name: "token",
        },
        {
            type: "uint256",
            name: "amount",
        },
    ]
    
};

contract('MetaCoin', (accounts) => {
  it('should put 10000 MetaCoin in the first account', async () => {
      console.log("testttt")
   // const metaCoinInstance = await Heritage.deployed();
    const tokenInstance = await Token.deployed();
  /*  const balance = await tokenInstance.getBalance.call(accounts[0]);
    console.log(balance )
    assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");*/
  });
  it('should call a function that depends on a linked library', async () => {
   /* const metaCoinInstance = await MetaCoin.deployed();
    const metaCoinBalance = (await metaCoinInstance.getBalance.call(accounts[0])).toNumber();
    const metaCoinEthBalance = (await metaCoinInstance.getBalanceInEth.call(accounts[0])).toNumber();

    assert.equal(metaCoinEthBalance, 2 * metaCoinBalance, 'Library function returned unexpected function, linkage may be broken');*/
  });
 
});
