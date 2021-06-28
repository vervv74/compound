const MyContract = artifacts.require('./contracts/MyContract.sol');
const comp = '0x2eaa9d77ae4d8f9cdd9faacd44016e746485bddb'//comptroller address

module.exports = async () => {
const myContract = await MyContract.deployed();
let result = await myContract.getLiquidity(comp);
console.log(web3.utils.fromWei(result));
  }
 
 