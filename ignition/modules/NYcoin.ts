import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("NYcoinModule", (m) => {
  const nycoin = m.contract("NYcoin");

  m.call(nycoin, "name");

  return { nycoin };
});
