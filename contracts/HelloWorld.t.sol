pragma solidity ^0.8.28;

import {HelloWorld} from "./HelloWorld.sol";
import {Test} from "forge-std/Test.sol";

contract HelloWorldTest is Test {
  HelloWorld helloWorld;

  function setUp() public {
    helloWorld = new HelloWorld();
  }

  function test_InitialMessage() public view {
    require(bytes(helloWorld.mymsg()).length > 0, "Initial value should be 0 as its by default set to Hello World!");
    require(keccak256(bytes(helloWorld.mymsg())) == keccak256(bytes("Hello World!")), "Initial value should be 'Hello World!'");
  }

  function testFuzz_setMsg(string memory newMessage) public {
    vm.assume(bytes(newMessage).length > 0);
    string memory oldMessage = helloWorld.mymsg();
    helloWorld.setMsg(newMessage);
    require(keccak256(bytes(helloWorld.mymsg())) == keccak256(bytes(newMessage)), "Value should be changed");
    require(keccak256(bytes(helloWorld.mymsg())) != keccak256(bytes(oldMessage)), "Value should be changed");
  }

  function testSetMsgRejectsEmptyString() public {
    bool success;
    (success,) = address(helloWorld).call(abi.encodeWithSignature("setMsg(string)", ""));
    require(!success, "setMsg should revert when message is empty");
  }

  function testSetMsgAcceptsNonEmptyString() public {
    helloWorld.setMsg("Non-empty");
    require(keccak256(bytes(helloWorld.mymsg())) == keccak256(bytes("Non-empty")), "setMsg should accept non-empty string");
  }

}
