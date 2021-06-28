const MyContract = artifacts.require('./contracts/MyContract.sol');
const cERC20 = '0x6d7f0754ffeb405d23c51ce938289d4835be3b14';//cDAi address
const comp = '0x2eaa9d77ae4d8f9cdd9faacd44016e746485bddb'//comptroller address

module.exports = async () => {
const myContract = await MyContract.deployed();
let result = await myContract.exit(comp, cERC20);

  console.log(result);

  }
 
 