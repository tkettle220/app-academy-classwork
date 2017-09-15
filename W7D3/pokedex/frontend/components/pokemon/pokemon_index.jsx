import React from 'react';
import PokemonIndexItem from './pokemon_index_item';
import { Route } from 'react-router-dom';
import PokemonDetailContainer from './pokemon_detail_container';



class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount () {
    this.props.requestAllPokemon();
  }

  render () {
    return(
      <div className="PokemonIndex">
        <ul className="PokemonSideBar">
        {this.props.pokemon.map(poke => <PokemonIndexItem key={poke.id} pokemon={poke} />)}
        </ul>
        <Route path="/pokemon/:pokemonID" component={PokemonDetailContainer} />
      </div>

    );
  }
}

export default PokemonIndex;
