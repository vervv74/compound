const MyContract = artifacts.require('MyContract.sol');

const c = '0x6d7f0754ffeb405d23c51ce938289d4835be3b14';//cDAi address


module.exports = async () => {
  const myContract = await MyContract.deployed();
 let res = await myContract.redeem(c,'6622405042');
console.log(res)
}