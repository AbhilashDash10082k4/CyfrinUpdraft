//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FirstContract {
    uint firstNumber = 256;
    int secondNumber = 355;
    address myAddress = 0x29784833bB49aD62b1eaE6A00b5CDcc421c0f8b4;
    string myFirstString = "adsince2k4";
    bytes32 mySecondString = "abhilash" ;//string and bytes mean the same thing under the hood, bytes32 is the hioghest

    uint favouriteNumber; //favouriteNumber is compiled to zero if it is not defined, public keyword changes the visibility

    uint[] listOfFavouriteNumbers; //[1,2,3,4,0,...]

    //deciding whose favourite no. is stored at which place

    //defining a custom type
    struct Person { //This type will store its name and its fav number
        uint256 genericFavouriteNumber;
        string name;
    }
    //creating the var with structure of Person
    Person public ad = Person({genericFavouriteNumber: 7, name: "adsince2k4"}); //type, visibility, name of the var

    //list of Persons
    Person[] public listOfPersons;

    mapping(string=>uint256) public nameToFavouriteNumber;

    //adding elems to Person
    function addPersons(uint _genericFavouriteNumber ,string memory _name) public {
        Person memory person = Person(_genericFavouriteNumber, _name);
        listOfPersons.push(person);
        nameToFavouriteNumber[_name] = _genericFavouriteNumber;
    }

    //function to store a number, updating favouriteNumber
    //virtual helps to override the function
    function update(uint256 _favouriteNumber) public virtual {
        favouriteNumber = _favouriteNumber;
    }

    //public keyword enables a getter function to return the variable
    //view, pure keywords => function dont get actually executed and I dont need to send transactions to call them
    //view-> will only read state from blockchain, prevents any modification
    function retrieve() public view returns (uint256) {
        return favouriteNumber;
    }
}