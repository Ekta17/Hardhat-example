// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NYcoin is ERC20 {

  constructor() ERC20("NYcoin", "NYC") {
    _mint(msg.sender, 1000000 * 10 ** decimals());
  }

}
