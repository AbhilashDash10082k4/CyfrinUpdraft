//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "contracts/SimpleStorage.sol";

contract StorageFactory {

    FirstContract public firstContract;
    function createStorageFactory() public {
        firstContract = new FirstContract();
    }
}