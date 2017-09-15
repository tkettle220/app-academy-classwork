import { RECEIVE_ALL_POKEMON, RECEIVE_POKEMON } from '../actions/pokemon_actions';
import merge from 'lodash/merge';

export const pokemonReducer = (state = {}, action) => {
  let newState = {};
  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
      newState = action.pokemon;
      return newState;
    case RECEIVE_POKEMON:
      const poke = action.poke.pokemon;
      console.log(action);
      newState = merge({}, state, { [poke.id]: poke});
      return newState;
    default:
      return state;
  }
};
