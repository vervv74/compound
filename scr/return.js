const MyContract = artifacts.require('MyContract.sol');
const cTok = '0x6d7f0754ffeb405d23c51ce938289d4835be3b14'//cToken address



module.exports = async () => {
  const myContract = await MyContract.deployed();
  let addr = await myContract.underAddress(cTok);
  console.log(addr);
 await myContract.transfer(addr,'0xa40342366d0833Fc89cb7Bf4238178B26af7623c','1999999999817894328');
}
