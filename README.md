# FundMe Project

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Deployment](#deployment)
- [How It Works](#how-it-works)
  - [Adding Funds](#adding-funds)
  - [Taking Out Funds](#taking-out-funds)
- [Testing](#testing)
- [Gas Efficiency](#gas-efficiency)
- [License](#license)

## Overview

The FundMe project is a smart contract built on the Ethereum blockchain using Solidity. It allows users to send Ether (ETH) to the contract, based on the current ETH to USD exchange rate provided by the Chainlink Price Feed. The contract has an owner who can withdraw the collected funds. The contract also ensures that each contribution meets a minimum amount in USD.

## Requirements

To use the FundMe contract, you need:

1. An Ethereum wallet (like MetaMask) to send transactions.
2. Some Ether (ETH) to contribute to the contract.
3. An Ethereum development environment, such as Remix or Truffle, or an Ethereum wallet that can interact with smart contracts.

## Getting Started

### Installation

1. Clone the FundMe repository from [GitHub Repository URL](https://github.com/KnightWolf2004/FoundryFundMe.git).

### Deployment

1. Deploy the FundMe contract using an Ethereum development environment like Remix or Truffle.

2. When deploying, provide the address of the Chainlink Price Feed contract to the constructor. This contract will provide the current ETH/USD price.

3. The account that deploys the contract becomes the owner. Only the owner can withdraw funds from the contract.

## How It Works

### Adding Funds

To add funds to the contract:

1. Call the `fund` function on the FundMe contract and send Ether with the transaction.

2. The contract will check the current ETH/USD price using the Chainlink Price Feed.

3. If the amount of ETH sent is equal to or above the minimum amount set in USD, the contract will record the contributor's address and the amount contributed.

### Taking Out Funds

Only the contract owner can take out the funds. To withdraw the collected funds:

1. Call the `withdraw` function on the FundMe contract.

2. The contract will tranfer all the funds to the Owner's account.

3. The contract balance will be reset to zero after the withdrawal.

## Testing

The FundMe contract has been tested to confirm its functionality. The tests cover different scenarios like contributing funds, checking the minimum amount requirement, and withdrawing funds.

To run the tests:

1. Open an Ethereum development environment (e.g., Remix or Truffle).

2. Deploy the FundMe contract on a local development network.

3. Run the test scripts found in the "tests" folder.

## Gas Efficiency

The FundMe contract is designed to use gas efficiently. Steps have been taken to keep gas costs low for all operations.
