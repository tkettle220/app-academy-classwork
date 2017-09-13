import { applyMiddleware, createStore } from 'redux';
import rootReducer from '../reducers/root_reducer';
import thunkMiddleware from '../middleware/thunk';

const initialState = {};

const configureStore = createStore(
  rootReducer, initialState, applyMiddleware(thunkMiddleware));

export default configureStore;
