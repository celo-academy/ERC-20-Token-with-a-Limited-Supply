// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC20TokenWithLimitedSupply is ERC20Burnable {
  /**Address of the contract owner
   *  Although, this is an owner, but it does not wedge much power
   * other than the privilege to mint token
  */ 
  address public owner;

  /**
   * 
   * @param _supply : Initial token supply. This amount will be minted at deployment and 
   * will reflect as the initial token supply.
   * Note: We also check that the supply amount does not exceed the maximum supply that can be minted
   * in the token lifecycle.
   * 
   * We also set the deployer as the owner
   */
  constructor(uint _supply) ERC20("SAGE Token", "SAGE") {
    require(_supply <= 1_000_000 * (10 ** decimals()), "Invalid supply");
    owner = _msgSender();
    _mint(_msgSender(), _supply);
  }

  /**@dev Anyone is able to burn token.
   * We override the burn() function that existed in the "ERC20Burnable"
   * that was imported from the openzepellin library.
   * 
   * @param amount : Amount to burn. 
   * Note: User's balance must exceed or equal to the requested burnt amount.
   */
  function burn(uint256 amount) public override(ERC20Burnable) {
    _burn(_msgSender(), amount);
  } 

  /**This is an only-owner function. 
   * When this function is called, the total supply increases.
   * If the caller is not the authorized account, the execution fails.
   * At any time this function is invoked, we ensure the requested amount 
   *    added to the current totalSupply does not surpass the maximium mintable
   *    token.
   * @param amount : Amount to mint
   * @param to : Address to receive the token.
   */
  function mint(uint amount, address to) public {
    uint maxSupply = 1_000_000 * (10 ** decimals());
    if(_msgSender() != owner) revert("Not An Owner");
    require((amount + totalSupply()) <= maxSupply, "Amount exceeds minting threshold");
    _mint(to, amount);
  }
}