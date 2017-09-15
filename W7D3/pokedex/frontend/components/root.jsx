import React from 'react';
import { Provider } from 'react-redux';
import PokemonContainer from './pokemon/pokemon_index_container';
import { HashRouter, Route } from 'react-router-dom';

const Root = ({ store }) => (
  <Provider store={store}>
    <HashRouter>
      <div>
        <Route path="/" component={PokemonContainer} />
      </div>
    </HashRouter>
  </Provider>
);

export default Root;
