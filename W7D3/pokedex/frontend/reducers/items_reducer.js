import { RECEIVE_POKEMON } from '../actions/pokemon_actions';
import merge from 'lodash/merge';

export const itemReducer = (state = {}, action) => {
  let newState = {};
  switch (action.type) {
    case RECEIVE_POKEMON:
      newState = action.poke.items;
      return newState;
    default:
      return state;
  }
};
