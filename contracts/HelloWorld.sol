// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract HelloWorld {

    string public mymsg = "Hello World!";
    event MessageUpdated(string message);

    function setMsg(string memory message) public {
        require(bytes(message).length > 0, "Message cannot be empty");
        mymsg = message;
        emit MessageUpdated(mymsg);
    }
}