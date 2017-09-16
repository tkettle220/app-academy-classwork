import React from 'react';
import ReactDOM from 'react-dom';

import * as SessionActions from './actions/session_actions';
import configureStore from './store/store';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  const store = configureStore();
  window.getState = store.getState;
  window.dispatch = store.dispatch;
  ReactDOM.render(<h1>Welcome to BenchBnB</h1>, root);
});


window.login = SessionActions.login;
window.logout = SessionActions.logout;
window.signup = SessionActions.signup;
