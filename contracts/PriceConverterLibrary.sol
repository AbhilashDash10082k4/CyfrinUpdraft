//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//PriceConverterLibrary is a SC that is a library which will have custom functions which will convert price
//libraries cant have any state vars and all the funs are marked as internal

//impporting this entire interface
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverterLibrary {
    //to get the val of 1ETH in USD
    function getPrice() internal view returns (uint256) {
        //ABI
        //ADRESS for conversion- 0x694AA1769357215DE4FAC081bf1f309aDC325306
        /*compiling the interface of chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol will give the abi
        */
        /*Getting real world price data from chainlink*/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        /*calling latestRoundData fn on pricefeed*/
        (,int256 answer,,,) = priceFeed.latestRoundData();
        /*Price = price of ETH in USD*/
        return uint256(answer*1e10);
    }

    //to conv msg.value to from ETH to USD
    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        //ethAmount - amount of ETH to be converted
        uint256 ethPrice = getPrice(); //1ETH IN USD
        //1ETH = 10**18 WEI
        /*Let 1ETH = 1000USD (IRL it will look like 10**18ETH = 1000_0000000000USD)
        the decimal places are taken into consideration as whole nos, so 1e18 is divided
        to cancel out the extra set of 18 0's*/
        uint ethAmountInUsd = ethPrice*ethAmount / 1e18; /*(USD * ETH)/1e18 */
        return ethAmountInUsd;
    }

    //withdraw funds sent to us
    function withdraw() internal {}

    //using that AggregatorV3interface
    /*This function calls the Chainlink price feed contract at address
    0x694AA1769357215DE4FAC081bf1f309aDC325306 to get the version 
    of the price feed by interacting with its version() function,
    which is defined in the AggregatorV3Interface
    */
    function getVersion() internal view returns (uint256) {
        //address is passed to AggregatorV3Interafce
        //the below line tells that this address has a version fn
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}