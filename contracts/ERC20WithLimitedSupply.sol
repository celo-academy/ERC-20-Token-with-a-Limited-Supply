// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC20TokenWithLimitedSupply is ERC20Burnable {
  address public owner;

  constructor(uint _supply) ERC20("SAGE Token", "SAGE") {
    require(_supply <= 1_000_000 * (10 ** decimals()), "Invalid supply");
    owner = _msgSender();
    _mint(_msgSender(), _supply);
  }

  function burn(uint256 amount) public override(ERC20Burnable) {
    _burn(_msgSender(), amount);
  } 

  function mint(uint amount, address to) public {
    uint maxSupply = 1_000_000 * (10 ** decimals());
    if(_msgSender() != owner) revert("Not An Owner");
    require((amount + totalSupply()) <= maxSupply, "Amount exceeds minting threshold");
    _mint(to, amount);
  }
}