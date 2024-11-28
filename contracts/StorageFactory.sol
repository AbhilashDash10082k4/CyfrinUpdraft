//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "contracts/SimpleStorage.sol";

contract StorageFactory {

    //list of all the different FirstContracts that are ran
    FirstContract[] public listOfFirstContracts;

    function createStorageFactory() public {
        FirstContract newFirstContract = new FirstContract(); //creation of new newFirstContract and deploying on FirstContract
        listOfFirstContracts.push(newFirstContract);
    }

    //interacting with contracts from other contracts
    function sfStorage(uint _firstContractIndex, uint256 _newFirstContractNumber) public {
        //to interact we need address and ABI
        //ABI- Application Binary Interface
        FirstContract myFirstContract = listOfFirstContracts[_firstContractIndex];
        myFirstContract.update(_newFirstContractNumber);
    }
   
    //to read the stored values in sfStorage
    function sfGet(uint _firstContractIndex) public view returns(uint256){ 
        FirstContract myFirstContract = listOfFirstContracts[_firstContractIndex];
        myFirstContract.retrieve();
    }
}