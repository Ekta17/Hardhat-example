// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {NYcoin} from "./NYcoin.sol";
import {Test} from "forge-std/Test.sol";

contract NYcoinTest is Test {
  NYcoin nycoin;

  function setUp() public {
     nycoin = new NYcoin();
  }

  function testInitialSupplyMintedToDeployer() public {
    assertEq(nycoin.balanceOf(address(this)), 1000000 * 10 ** nycoin.decimals(), "Deployer should have initial supply");
  }

  function testOtherAddressHasZeroBalance() public {
    address other = address(0xBEEF);
    assertEq(nycoin.balanceOf(other), 0, "Other address should have zero balance");
  }

  function testTokenMetadata() public {
    assertEq(nycoin.name(), "NYcoin", "Token name should be NYcoin");
    assertEq(nycoin.symbol(), "NYC", "Token symbol should be NYC");
    assertEq(nycoin.decimals(), 18, "Token decimals should be 18");
  }
}
