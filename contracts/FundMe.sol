//Recieve funds
//Withdraw funds
//Take a min fund of 5USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FundMe {

    //recieve funds from user to our contracts, user will call this func to send money to our contract
    function fund() public payable {
        //Allow users to send money above a min val
        //S1. Sending ETH to this contract
        /*payable- makes the contract to be able to accept native blockchain currency
        after deploying contract are almost similar to wallets: have wallet address, have a balance, recieve and send currency
        */

        //require - min requirement, msg.val = val of wei sent, 1e18 = 1ETH == 1 * 10**18 WEI
        require(msg.value > 1e18, "Why so Kanjus! Send the entire amount specified");
        


    }

    //withdraw funds sent to us
    function withdraw() public {}
}