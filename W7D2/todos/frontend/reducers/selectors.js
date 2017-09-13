import React from 'react';

export const allTodos = (state) => {
  const keys = Object.keys(state.todos)
                .map((key) => parseInt(key))
                .sort((a, b) => a - b);
  const todos = [];

  keys.forEach((key) => {
    todos.push(state.todos[key]);
  });
  return todos;
};

export const allErrors = (state) => {
  return state.errors;
};
