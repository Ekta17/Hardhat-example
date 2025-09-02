import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("HelloWorldModule", (m) => {
  const helloWorld = m.contract("HelloWorld");

  m.call(helloWorld, "setMsg", ["Salut!"]);

  return { helloWorld };
});
