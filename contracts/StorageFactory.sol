//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "contracts/SimpleStorage.sol";

contract StorageFactory {

    FirstContract[] public listOfFirstContracts; //list of all the different FirstContracts that are runned
    function createStorageFactory() public {
        FirstContract newFirstContract = new FirstContract(); //creation of new newFirstContract
        listOfFirstContracts.push(newFirstContract);
    }
}