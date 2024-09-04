// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

//script for funding
contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployedContract) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployedContract)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("FundMe funded with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeployedContract = DevOpsTools
            .get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployedContract);
        vm.stopBroadcast();
    }
}

//script for withdrawing
contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployedContract) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployedContract)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployedContract = DevOpsTools
            .get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        withdrawFundMe(mostRecentlyDeployedContract);
        vm.stopBroadcast();
    }
}
