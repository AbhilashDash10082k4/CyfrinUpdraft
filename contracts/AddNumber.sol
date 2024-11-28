// SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {FirstContract} from "contracts/SimpleStorage.sol";

//inherit FirstContract to AddNumber
//AddNumber is a function to store +7 of the original given by users
contract AddNumber is FirstContract {
    //override is used to overwrite the storage function to store +7 of the input given
    function update(uint _newNumber) public override {
        favouriteNumber = _newNumber + 7;
    }
}