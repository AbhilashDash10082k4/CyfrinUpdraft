//Recieve funds
//Withdraw funds
//Take a min fund of 5USD

/*Interact from this contract to other contracts outside of this project-
1.get the interface
2.compile it to get the abi
3.wrap the address of the convetre around the interface with .version()*/
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//this interface can be used to call api
//this is an  interface for Chainlink's price feed contract

// interface AggregatorV3Interface {
//   function decimals() external view returns (uint8);
//   function description() external view returns (string memory);
//   function version() external view returns (uint256);
//   function getRoundData(
//     uint80 _roundId
//   ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
//   function latestRoundData()
//     external
//     view
//     returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
// }

//impporting this entire interface
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    //converting usd to dollars
    /*as the getConversionRate returns a no with 18 decimal places so,7*1e18*/
    uint256 public minUSD = 7e18;

    /*tracking users who are sending money*/
    address[] public funders;

    /*mapping Mount of money each user has sent*/
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    //recieve funds from user to our contracts, user will call this func to send money to our contract
    function fund() public payable {
        //Allow users to send money above a min val
        //S1. Sending ETH to this contract
        /*payable- makes the contract to be able to accept native blockchain currency
        after deploying contract are almost similar to wallets: have wallet address, have a balance, recieve and send currency
        */

        /*even if the transaction fails, still it will cost me gas as the computer executed the transaction, gas cost is paid for transacting and does not depend upon success of transaction
        */
        //require - min requirement, msg.val = val of wei sent, 1e18 = 1ETH == 1 * 10**18 WEI
        
        /*getConversionRate will convert the ETH into USD*/
        require(getConversionRate(msg.value) > minUSD, "Why so Kanjus! Send the entire amount specified");
        
        //msg.value is in WEI and minUSD is in USD, so convert WEI to USD
        /*using ORACLE
        ORACLE PRBLM = blockchains are unable to interact with outside world
        bchains are deterministic system so that all the nodes can reach consensus
        if extetrnal data or API are fed each node will reac to a diff value and will never reach any consensus
        so blockchain oracle interacts with offchain to provide external data to scontracts
        Chainlink is a decentralized oracle network which links scontract with real world, this creates hybrid SC
        
        features of Chainlink

        1.data feeds- 50blln USD in DeFi world
            chainlink vrf gets a provably random number, random nos are not random once they r predicted and bchains are deterministic i.e they cannot be random
            so to have a random no. chainlink vrf is used
        */
        funders.push(msg.sender); /*msg.sender refers to the sender sending ETH*/
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    //to get the val of 1ETH in USD
    function getPrice() public view returns (uint256) {
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
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
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
    function withdraw() public {}

    //using that AggregatorV3interface
    /*This function calls the Chainlink price feed contract at address
    0x694AA1769357215DE4FAC081bf1f309aDC325306 to get the version 
    of the price feed by interacting with its version() function,
    which is defined in the AggregatorV3Interface
    */
    function getVersion() public view returns (uint256) {
        //address is passed to AggregatorV3Interafce
        //the below line tells that this address has a version fn
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}