const MyContract = artifacts.require('./contracts/MyContract.sol');


module.exports = async () => {
  const myContract = await MyContract.deployed();
  let result = await myContract.fullrepay();
console.log(result);
  }
 
 