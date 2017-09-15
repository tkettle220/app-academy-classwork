import values from 'lodash/values';

export const selectAllPokemon = (state) => {
  return values(state.entities.pokemon);
};

export const selectOnePokemon = (state, id) => {
  return values(state.entities.pokemon)[`${id}`];
};
