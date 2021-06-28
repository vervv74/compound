const MyContract = artifacts.require('./contracts/MyContract.sol');
//const Compound = require('@compound-finance/compound-js')
const cERC20 = '0x6d7f0754ffeb405d23c51ce938289d4835be3b14';//cDAi address
const pr = '0x5722A3F60fa4F0EC5120DCD6C386289A4758D1b2'/// oracle address
const comp = '0x2eaa9d77ae4d8f9cdd9faacd44016e746485bddb'//comptroller address

module.exports = async () => {
    const myContract = await MyContract.deployed();
    let add = await myContract.ContractAddress();
   
    let addErc = await myContract.underAddress(cERC20);
    let bal = await myContract.balance(addErc, add);
    let pri = await myContract.price(pr, cERC20);
    try {let coll = await myContract.collateral(comp, cERC20);
    console.log(`collateral factor - ${coll}`);
    } catch(error) {console.log(error);}
    //let coll = await myContract.collateral(comp, cERC20);
    
   // let balance = await Compound.eth.getBalance(add);
 

 console.log(`Contract Address - ${add}`);
 console.log(`Under Address - ${addErc}`);
 console.log(`Dai Balance - ${bal}`);
 console.log(`price - ${pri}`);

 //console.log(b);


 //let qwe1 = await myContract.getMaxBorrow(qwe);
  }
 