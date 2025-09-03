pragma solidity ^0.8.28;

import {ToDoList} from "./ToDoList.sol";
import {Test} from "forge-std/Test.sol";

contract ToDoListTest is Test {
  ToDoList toDoList;

  function setUp() public {
    toDoList = new ToDoList();
  }

  function testCreateTaskAndEmitEvent() public {
    vm.expectEmit(true, false, false, true);
    emit ToDoList.TaskCreated(0, "Task 1");
    toDoList.createTask("Task 1");

    (string memory text, bool completed) = toDoList.getTask(0);
    assertEq(text, "Task 1");
    assertEq(completed, false);

  }

  function testToggleTaskStatusToCompleted() public {
    toDoList.createTask("Task 1");
    vm.expectEmit(true, false, false, true);
    emit ToDoList.TaskCompleted(0, true);
    toDoList.toggleTaskCompleted(0);
    (, bool completed) = toDoList.getTask(0);
    assertEq(completed, true);
  }

  function testToggleTaskStatusToBackToFalseAfterCompleted() public {
    toDoList.createTask("Task 2");
    toDoList.toggleTaskCompleted(0);
    toDoList.toggleTaskCompleted(0);
    (, bool completed) = toDoList.getTask(0);
    assertEq(completed, false);
  }

  function testGetTaskByTaskId() public {
    toDoList.createTask("Task 1");
    (string memory text1, bool completed1) = toDoList.getTask(0);
    assertEq(text1, "Task 1");
    assertEq(completed1, false);
  }

  function revertsForInvalidTaskId() public {
    vm.expectRevert(bytes("getTask: invalid taskId"));
    toDoList.getTask(0);
  }

  function testGetTaskId() public {
    toDoList.createTask("Task 1");
    uint taskId = toDoList.getTaskId("Task 1");
    assertEq(taskId, 0);
    uint taskNotPresent = toDoList.getTaskId("Non-existent Task");
    assertEq(taskNotPresent, type(uint).max);
  }

  function testGetTaskIdWhenTextIsEmpty() public {
    vm.expectRevert(bytes("getTaskId: text cannot be empty"));
    toDoList.getTaskId("");
  }

  function testGetTasksCount() public {
    assertEq(toDoList.getTasksCount(), 0);
    toDoList.createTask("Task 1");
    toDoList.createTask("Task 2");
    uint count = toDoList.getTasksCount();
    assertEq(count, 2);
  }

  function testRevertsWhenTogglingCompletionForInvalidTaskId() public {
    vm.expectRevert();
    toDoList.toggleTaskCompleted(0);
  }

  function testRevertsWhenGettingTaskWithInvalidTaskId() public {
    vm.expectRevert(bytes("getTask: invalid taskId"));
    toDoList.getTask(0);
  }

  function testHandlesMultipleTasksIndependently() public {
    toDoList.createTask("Task A");
    toDoList.createTask("Task B");
    toDoList.toggleTaskCompleted(1);
    (, bool completedA) = toDoList.getTask(0);
    (, bool completedB) = toDoList.getTask(1);
    assertEq(completedA, false);
    assertEq(completedB, true);
  }

}
