import React from 'react';
import ReactDOM from 'react-dom';

import configureStore from './store/store';
import Root from './components/root';
import {receiveTodos, receiveTodo} from './actions/todo_actions';

import allTodos from './reducers/selectors';





document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <Root store={store}/>,
    document.getElementById('root')
  );

});

const store = configureStore;
window.store = store;
window.receiveTodo = receiveTodo;
window.receiveTodos = receiveTodos;
window.allTodos = allTodos;
