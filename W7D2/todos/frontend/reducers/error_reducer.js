const initialState = [];
import {RECEIVE_ERRORS, CLEAR_ERRORS} from '../actions/error_actions';


const errorReducer = (oldState = initialState, action) => {
  let newState = [];
  switch (action.type) {
    case RECEIVE_ERRORS:
      if (action.errors) {
        return Array.from(action.errors);
      }
      else {
        return newState;
      }
    case CLEAR_ERRORS:
      return newState;
    default:
      return oldState;
  }
};

export default errorReducer;
