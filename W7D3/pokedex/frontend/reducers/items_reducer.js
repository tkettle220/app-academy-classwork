import { RECEIVE_POKEMON } from '../actions/pokemon_actions';
import merge from 'lodash/merge';

export const itemsReducer = (state = {}, action) => {
  let newState = {};
  switch (action.type) {
    case RECEIVE_POKEMON:
      newState = action.poke.pokemon.item_ids;
      return newState;
    default:
      return state;
  }
};
