import { combineReducers } from 'redux';
import { pokemonReducer, itemsReducer } from './pokemon_reducer';

const entitiesReducer = combineReducers({
  pokemon: pokemonReducer,
  items: itemsReducer
});

export default entitiesReducer;
