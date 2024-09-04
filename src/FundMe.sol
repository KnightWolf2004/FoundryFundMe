// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

error FundMe__NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    //made private for gas efficiency
    //we make storage functions with s_
    mapping(address sender => uint256 amountFunded)
        private s_adressToAmountFunded;
    address[] private s_funders;

    address private immutable i_owner;
    uint256 public constant MIN_USD = 5 * 1e18;
    AggregatorV3Interface private s_priceFeed;

    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(s_priceFeed) >= MIN_USD,
            "Not enough ETH"
        );

        s_adressToAmountFunded[msg.sender] += msg.value;
        s_funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

    function cheaperWithdraw() public onlyOwner {
        //we make this variable so that we don't have to call from storage very time.
        uint256 fundersLength = s_funders.length;
        for (
            uint256 fundersIndex = 0;
            fundersIndex < fundersLength;
            fundersIndex++
        ) {
            address tempfunder = s_funders[fundersIndex];
            s_adressToAmountFunded[tempfunder] = 0;
        }
        s_funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");

        require(callSuccess, "Call Failed");
    }

    function withdraw() public onlyOwner {
        for (
            uint256 fundersIndex = 0;
            fundersIndex < s_funders.length;
            fundersIndex++
        ) {
            address tempfunder = s_funders[fundersIndex];
            s_adressToAmountFunded[tempfunder] = 0;
        }

        s_funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");

        require(callSuccess, "Call Failed");
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

    //getter functions | to check the value in private functions
    function getAddressToAmountFunded(
        address fundingAddress
    ) external view returns (uint256) {
        return s_adressToAmountFunded[fundingAddress];
    }

    function getFunder(uint256 index) external view returns (address) {
        return s_funders[index];
    }

    function getOwner() external view returns (address) {
        return i_owner;
    }
}
