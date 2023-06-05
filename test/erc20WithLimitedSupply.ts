import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
// import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("ERC20TokenWithLimitedSupply", function () {
  async function deployTokenFixture() {
    const INIT_SUPPLY = "1000000000000000000000";
    const NAME = "SAGE Token";
    const SYMBOL = "SAGE";
    const DECIMALS = 18;

    const [owner, otherAccount] = await ethers.getSigners();

    const ERC20TokenWithLimitedSupply = await ethers.getContractFactory("ERC20TokenWithLimitedSupply");
    const token = await ERC20TokenWithLimitedSupply.deploy(INIT_SUPPLY);
    await token.deployed();

    return {
      token , 
      INIT_SUPPLY,
      NAME,
      SYMBOL,
      DECIMALS,
      owner, 
      otherAccount 
    };
  }

  describe("Deployment", function () {
    it("Should set the token name correctly", async function () {
      const { token, NAME  } = await loadFixture(deployTokenFixture);

      expect(await token.name()).to.equal(NAME);
    });

    it("Should set the token symbol correctly", async function () {
      const { token, SYMBOL  } = await loadFixture(deployTokenFixture);

      expect(await token.symbol()).to.equal(SYMBOL);
    });

    it("Should set the token decimals correctly", async function () {
      const { token, DECIMALS  } = await loadFixture(deployTokenFixture);

      expect(await token.decimals()).to.equal(DECIMALS);
    });

    it("Should set the right owner", async function () {
      const { token, owner } = await loadFixture(deployTokenFixture);

      expect(await token.owner()).to.equal(owner.address);
    });

    it("Should confirm current totalsupply equals initial supply", async function () {
      const { token, INIT_SUPPLY } = await loadFixture(deployTokenFixture);

      expect((await token.totalSupply()).toString()).to.equal(INIT_SUPPLY.toString());
    });

    it("Should mint token successfully", async function () {
      const amount = '1000000000000000000000'
      const { token, otherAccount, owner } = await loadFixture(deployTokenFixture);
      const initBalanceOfOtherAccount = await token.balanceOf(otherAccount.address);
      await token.connect(owner).mint(otherAccount.address, amount);
      expect((await token.balanceOf(otherAccount.address)).toString()).to.equal(initBalanceOfOtherAccount.add(amount).toString());
    });

    it("Should revert if account other than owner try to mint", async function () {
      const { token, otherAccount} = await loadFixture(deployTokenFixture);
      expect(await token.connect(otherAccount).mint(otherAccount.address, '100000000000000')).to.revertedWith("Not An Owner");
    });
  });

});