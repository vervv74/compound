const MyContract = artifacts.require('./contracts/MyContract.sol');
const cBat = '0xd6801a1dffcd0a410336ef88def4320d6df1883e';//cBat address


module.exports = async () => {
const myContract = await MyContract.deployed();
await myContract.borrow(cBat, '500000000000000');
//let bal = await myContract.borrowBalanceCurrent(cBat);
//let bal2 = JSON.stringify(bal);
//console.log(`borrow balance  - ${bal}`)
  }
 
 