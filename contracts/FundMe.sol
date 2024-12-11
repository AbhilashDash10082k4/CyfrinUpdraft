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
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}
contract FundMe {

    uint256 public myValue = 1;

    //converting usd to dollars
    uint256 public minUSD = 7;

    //recieve funds from user to our contracts, user will call this func to send money to our contract
    function fund() public payable {
        //Allow users to send money above a min val
        //S1. Sending ETH to this contract
        /*payable- makes the contract to be able to accept native blockchain currency
        after deploying contract are almost similar to wallets: have wallet address, have a balance, recieve and send currency
        */
        myValue = myValue + 7;

        //even if the transaction fails, still it will cost me gas as the computer executed the transaction, gas cost is paid for transacting and does not depend upon success of transaction
        //require - min requirement, msg.val = val of wei sent, 1e18 = 1ETH == 1 * 10**18 WEI
        
        require(msg.value > minUSD, "Why so Kanjus! Send the entire amount specified");
        
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
    }
    //to get the val of 1ETH in USD
    function getPrice() public {
        //ABI
        //ADRESS for conversion- 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //compiling the interface of chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol will give the abi
    }

    //to conv this value to specified value
    function getConversionRate() public {
        
    }

    //withdraw funds sent to us
    function withdraw() public {}

    //using that AggregatorV3interface
    function getVersion() public view returns (uint256) {
        //address is passed to AggregatorV3Interafce
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}