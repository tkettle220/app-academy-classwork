const APIUtil = require ('../util/todo_api_util');
import {receiveErrors} from './error_actions';

export const RECEIVE_TODOS = 'RECEIVE_TODOS';
export const RECEIVE_TODO = 'RECEIVE_TODO';
export const REMOVE_TODO = 'REMOVE_TODO';
export const UPDATE_TODO = 'UPDATE_TODO';

export const receiveTodos = (todos = []) => ({
  type: RECEIVE_TODOS,
  todos
});

export const receiveTodo = (todo = {}) =>{
  return {type: RECEIVE_TODO,
  todo};
};

export const removeTodo = (id)=> {
  return {
    type: REMOVE_TODO,
    id
  };
};

export const updateTodo = (todo) => {
  return (dispatch) => {
    return APIUtil.updateTodo(todo).then(
      newTodo => dispatch(receiveTodo(newTodo)),
      err => dispatch(receiveErrors(err.responseJSON))
    );
  };
};

export const deleteTodo = (id) => {
  return (dispatch) => {
    return APIUtil.removeTodo(id).then(
      todo => dispatch(removeTodo(id)),
      err => dispatch(receiveErrors(err.responseJSON))
    );
  };
};

export const fetchTodos = () => {
  return (dispatch) => {
    return APIUtil.getTodos().then((todos) => dispatch(receiveTodos(todos)));
  };
};

export const createTodo = (todo) => {
  return (dispatch) => {
    return APIUtil.addTodo(todo).then(
      newTodo => dispatch(receiveTodo(newTodo)),
      err => dispatch(receiveErrors(err.responseJSON))
    );
  };
};
