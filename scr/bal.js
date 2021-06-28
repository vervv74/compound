const MyContract = artifacts.require('./contracts/MyContract.sol');
//const Compound = require('@compound-finance/compound-js')
const cERC20 = '0x6d7f0754ffeb405d23c51ce938289d4835be3b14';//cDAi address


module.exports = async () => {
    const myContract = await MyContract.deployed();
    let add = await myContract.ContractAddress();
    let bal = await myContract.balance(cERC20, add);
    let balU = JSON.stringify(await myContract.balanceU(cERC20, add));
   // let balance = await Compound.eth.getBalance(add);
 
   console.log(`sc address - ${add}`);
 console.log(`cDai balance - ${bal}`);
 console.log(`Dai balance- ${balU}`);

 //console.log(b);


 //let qwe1 = await myContract.getMaxBorrow(qwe);
  }
 