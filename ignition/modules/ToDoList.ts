import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("ToDoListModule", (m) => {
  const todoList = m.contract("ToDoList");

  m.call(todoList, "createTask", ["Create ToDoList Smart Contract"]);

  return { todoList };
});
