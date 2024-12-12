//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FallBack {
    uint256 public result;
    
    /*When ETH is sent or any txn is sent which has no data associated with it, then the receive fn is called*/
    receive() external payable {
        result = 1;
    }
    /*if the data entered is not recognized then this fn is called*/
    fallback() external payable {
        result = 2;
    }
}