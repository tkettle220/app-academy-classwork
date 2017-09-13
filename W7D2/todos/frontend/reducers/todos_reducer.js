import {
          RECEIVE_TODOS,
          RECEIVE_TODO,
          REMOVE_TODO,
          UPDATE_TODO
        } from "../actions/todo_actions";



const initialState = {};

const todosReducer = (oldState = initialState, action) => {
  let newState = {};

  switch (action.type) {

    case RECEIVE_TODOS:
      action.todos.forEach((todo)=>{
        newState[todo.id] = todo;
      });
      return newState;
    case RECEIVE_TODO:
      const todo = action.todo;
      newState = Object.assign(newState, oldState);
      newState[todo.id] = todo;
      return newState;
    case REMOVE_TODO:
      newState = Object.assign(newState, oldState);
      delete newState[action.id];
      return newState;
    default:
      return oldState;

  }
};

export default todosReducer;
