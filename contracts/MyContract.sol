// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2

//import "@openzeppelin/contracts/math/SafeMath.sol";

interface ERC20 {
    function approve(address, uint256) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

interface CERC20 {
    function mint(uint mintAmount) external returns (uint);
    function balanceOf(address owner) external view returns (uint256);
    function balanceOfUnderlying(address owner) external returns (uint);
    function redeem(uint redeemTokens) external returns (uint);
    function redeemUnderlying(uint redeemAmount) external returns (uint);
    function underlying() external view returns(address);
    function borrow(uint borrowAmount) external returns (uint);
  function repayBorrow(uint repayAmount) external returns (uint);
  function repayBorrow() external payable;
  function borrowBalanceCurrent(address account) external returns (uint);
}

interface ComptrollerInterface {
  function enterMarkets(address[] calldata cTokens) external returns (uint[] memory);
  function getAccountLiquidity(address owner) external view returns(uint, uint, uint);
  function exitMarket(address cToken) external returns (uint);
  function markets(address cTokenAddress) external view returns (bool, uint, bool);
}
interface PriceOracle {
  function getUnderlyingPrice(address asset) external view returns(uint);
}

contract MyContract  {
  //using SafeMath for uint;
event qwe1(uint _qwe);
    function ContractAddress() public view returns(address){ //Contract address
         return address(this);
     }
  
    function balance(address tokenAddress, address account) external view returns (uint256){
      CERC20  cERC20  = CERC20(tokenAddress);
      return cERC20.balanceOf(account);
    }
    function balanceU(address tokenAddress, address account) external returns (uint256){
      CERC20  cERC20  = CERC20(tokenAddress);
      return cERC20.balanceOfUnderlying(account);
    }
    function transfer(address tokenAddress, address _recipient, uint256 _amount) external returns (bool){
      ERC20  eRC20  = ERC20(tokenAddress);
      return eRC20.transfer(_recipient, _amount);
    }
    
    
     receive() external payable {
    }
    function supply(address payable cTokenAddress, uint underlyingAmount) external {
       CERC20  cERC20  = CERC20(cTokenAddress);
       address underlyingAddress = cERC20.underlying(); 
       ERC20  eRC20  = ERC20(underlyingAddress);
       eRC20.approve(cTokenAddress, underlyingAmount);
       cERC20.mint(underlyingAmount);
    }
     function underAddress(address cTokenAddress) external view returns (address) {
       CERC20  cERC20  = CERC20(cTokenAddress);
       address underlyingAddress = cERC20.underlying(); 
       return underlyingAddress;
    }
 
    function redeemU(address cTokenAddress, uint cTokenAmount) external returns(uint) {
    CERC20  cERC20  = CERC20(cTokenAddress);
    uint result;
    result =  cERC20.redeemUnderlying(cTokenAmount);
    require(
      result == 0,
      'cToken#redeem() failed'
    );
    return result;
  }
  function redeem(address cTokenAddress, uint cTokenAmount) external {
    CERC20  cERC20  = CERC20(cTokenAddress);
    uint result;
    result =  cERC20.redeem(cTokenAmount);
    require(
      result == 0,
      'cToken#redeem() failed'
    );
  }
  function enter(address comp, address cTokenAddress) external returns(uint){
    ComptrollerInterface comptroller = ComptrollerInterface(comp);
    address[] memory markets = new address[](1);
    markets[0] = cTokenAddress; 
    uint[] memory results = comptroller.enterMarkets(markets);
    require(
      results[0] == 0, 
      'comptroller#enterMarket() failed. see Compound ErrorReporter.sol for details'
    ); 
    return results[0];
  }
function exit(address comp, address cToken) external returns(uint){
  ComptrollerInterface comptroller = ComptrollerInterface(comp);
  uint result = comptroller.exitMarket(cToken);
  require(
      result == 0, 
      'comptroller#enterMarket() failed. see Compound ErrorReporter.sol for details'
    );
    return result;
}
function getLiquidity(address comp) external view returns(uint){
ComptrollerInterface comptroller = ComptrollerInterface(comp);
(uint result, uint liquidity, uint shortfall) = comptroller
      .getAccountLiquidity(address(this));
       require(
      result == 0, 
      'comptroller#getAccountLiquidity() failed. see Compound ErrorReporter.sol for details'
    ); 
    require(shortfall == 0, 'account underwater');
    require(liquidity > 0, 'account does not have collateral');
    return liquidity;
}
function price(address _priceOracle, address cToken) external view returns(uint) {
  PriceOracle priceOracle = PriceOracle(_priceOracle);
  return priceOracle.getUnderlyingPrice(cToken);
}
function collateral(address comp, address cToken) external view returns(uint) {
  ComptrollerInterface comptroller = ComptrollerInterface(comp);
  (bool isListed, uint collateralFactorMantissa, bool rt) = comptroller.markets(cToken);
  return collateralFactorMantissa;
}
function borrow(address cTokenAddress, uint borrowAmount) external {
    CERC20 cToken = CERC20(cTokenAddress);
   
    uint result = cToken.borrow(borrowAmount);
    require(
      result == 0, 
      'cToken#borrow() failed. see Compound ErrorReporter.sol for details'
    ); 
  }
  function repayBorrowERC20(address cTokenAddress, uint underlyingAmount) external {
     CERC20 cToken =  CERC20(cTokenAddress);
     address underlyingAddress = cToken.underlying(); 
     ERC20 eRC20 =  ERC20(underlyingAddress);
     eRC20.approve(cTokenAddress, underlyingAmount);
    uint result = cToken.repayBorrow(underlyingAmount);
    require(
      result == 0, 
      'cToken#borrow() failed. see Compound ErrorReporter.sol for details'
    ); 
  }
  function repayBorrowERC20full(address cTokenAddress) external {
     CERC20 cToken =  CERC20(cTokenAddress);
     address underlyingAddress = cToken.underlying(); 
     ERC20 eRC20 =  ERC20(underlyingAddress);
     uint  am = uint(-1);
     eRC20.approve(cTokenAddress, am);
    uint256 result = cToken.repayBorrow(am);
    require(
      result == 0, 
      'cToken#borrow() failed. see Compound ErrorReporter.sol for details'
    ); 
  }
function repayBorrowEth(address cTokenAdd, uint amount) external {
    CERC20 cToken =  CERC20(cTokenAdd);
     cToken.repayBorrow{value:amount}();
  }  
  function repayBorrowEthFull(address cTokenAdd) external {
    CERC20 cToken =  CERC20(cTokenAdd);
     uint  am = uint(-1);
     cToken.repayBorrow{value:am}();
  }  
  function fullrepay() external returns(uint){
     //uint qwe = uint(-1);
    return abi.encode(uint(-1);
    //emit qwe1(qwe);
  }  

 function  borrowBalanceCurrent(address cTokenAddress) external returns (uint256){
     CERC20 cToken =  CERC20(cTokenAddress);
    uint256 result = cToken.borrowBalanceCurrent(address(this)); 
    return result;
  }

}