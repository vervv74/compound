const MyContract = artifacts.require('./contracts/MyContract.sol');
const cBat = '0xd6801a1dffcd0a410336ef88def4320d6df1883e';//cBat address


module.exports = async () => {
const myContract = await MyContract.deployed();
//let bal = await myContract.borrowBalanceCurrent(cBat);
//let bal2 = web3.utils.toBN(bal);
await myContract.repayBorrowEthFull(cBat);
//let bal = JSON.stringify(await myContract.borrowBalanceCurrent(cEth));
//console.log(`borrow balance  - ${bal}`)
  }
 
 