import React from 'react';

const allTodos = (state) => {
  const keys = Object.keys(state.todos);
  const todos = [];

  keys.forEach((key) => {
    todos.push(state.todos[key]);
  });
  console.log(todos);
  return todos;
};

export default allTodos;
