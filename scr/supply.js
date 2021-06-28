const MyContract = artifacts.require('MyContract.sol');

const cERC20 = '0x6d7f0754ffeb405d23c51ce938289d4835be3b14';//cDAi address
const ERC20 = '0x5592ec0cfb4dbc12d3ab100b257153436a1f0fea';


module.exports = async () => {
  const myContract = await MyContract.deployed();
 await myContract.supply(cERC20, '1500000000000000000');
 

 /* let invest = await myContract.balanceInvested(cEth);
console.log(`Invested ${JSON.stringify(invest)}`); */
}