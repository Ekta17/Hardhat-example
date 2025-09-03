// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ToDoList {
    struct Task {
        string text;
        bool completed;
    }

    Task[] public tasks;

    event TaskCreated(uint indexed taskId, string text);
    event TaskCompleted(uint indexed taskId, bool completed);

    function createTask(string memory text) public {
        tasks.push(Task(text, false));
        uint taskId = tasks.length - 1;
        emit TaskCreated(taskId, text);
    }

    function toggleTaskCompleted(uint taskId) public {
        require(taskId < tasks.length, "toggleTaskCompleted: invalid taskId");
        tasks[taskId].completed = !tasks[taskId].completed;
        emit TaskCompleted(taskId, tasks[taskId].completed);
    }

    function getTask(uint taskId) public view returns (string memory text, bool completed) {
        require(taskId < tasks.length, "getTask: invalid taskId");
        Task storage task = tasks[taskId];
        return (task.text, task.completed);
    }

    function getTaskId(string memory text) public view returns (uint taskId) {
        require(bytes(text).length > 0, "getTaskId: text cannot be empty");
        for(uint i = 0; i < tasks.length; i++) {
            if(keccak256(bytes(tasks[i].text)) == keccak256(bytes(text))) {
                return i;
            }
        }
        return type(uint).max; //task not found
    }

    function getTasksCount() public view returns (uint) {
        return tasks.length;
    }
}