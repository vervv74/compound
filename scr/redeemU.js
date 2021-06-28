const MyContract = artifacts.require('MyContract.sol');

const c = '0x6d7f0754ffeb405d23c51ce938289d4835be3b14';//cDai address


module.exports = async () => {
  const myContract = await MyContract.deployed();
 let res = await myContract.redeemU(c,'1499999999817894328');
console.log(res)
}