# Introduction

Solidity is the primary language for writing smart contracts on the Celo blockchain. In this challenge, you will create a basic ERC-20 token with a limited supply.

https://celo.academy/t/erc-20-token-with-a-limited-supply/1566

## Problem Statement

Create an ERC-20 token with the following requirements:

1. The token should have a name, a symbol, and a total supply of tokens that are pre-minted and assigned to the creator of the contract.
2. The contract should comply with the ERC-20 standard, including `totalSupply`, `balanceOf`, `transfer`, `transferFrom`, `approve`, and `allowance` functions.
3. The contract should also include a `burn` function, allowing a user to destroy some of their own tokens, reducing the total supply.
4. A `mint` function should be present but can only be called by the contract creator and should respect the maximum supply limit.
5. The maximum supply of the token should be limited to 1 million tokens.

## Hints

1. You can start by defining the state variables for the token name, symbol, total supply, and balances of each address.
2. You will need to use the `msg.sender` global variable to assign the total supply to the contract creator.
3. The `transfer` function should check that the sender has enough tokens to send, subtract the amount from the sender's balance, and add it to the recipient's balance.
4. The `approve` function allows a certain address to spend a certain amount of tokens on behalf of the owner.
5. The `transferFrom` function should check that the spender has enough of an allowance to send the tokens, then do the same as the `transfer` function.
6. The `burn` function should check that the burner has enough tokens to burn, then subtract the burned amount from their balance and the total supply.
7. The `mint` function should increase the total supply and the balance of the minter, but only if the minter is the contract creator and the total supply won't exceed the maximum supply.

## Evaluation Criteria

- Correctness: The contract should compile without errors and fulfill all the requirements.
- Readability: The contract should be well-documented, with comments explaining the code.
- Testability: You should also provide examples of how to test each function of the contract.

Please note that handling real assets on a blockchain requires extreme care and extensive testing. This challenge is a simple exercise and doesn't cover aspects such as security, efficiency, and upgradability, which are essential for a real-world token contract.

For the complete understanding of Celo smart contracts, ERC-20 standard, and Solidity, please refer to the Celo documentation and the Solidity language documentation.

## Submission

Please reply with a link to your deployed token contract on [Celoscan](https://celoscan.io/), along with any notes or comments you think are necessary to understand your design and choices. Also, provide a brief explanation about how each function of the contract should be tested.
