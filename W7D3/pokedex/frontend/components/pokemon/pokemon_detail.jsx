import React from 'react';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    let id = parseInt(this.props.match.params.pokemonID)
    this.props.requestPokemon(id);
  }

  render () {
    const poke = this.props.pokemon[parseInt(this.props.match.params.pokemonID)];
    return (
      <div className="PokemonDetail">

      <img src={poke.image_url}></img>
        <ul className="PokemonAttributes">
          <li>Id: {poke.id}</li>
          <li>Name: {poke.name}</li>
          <li>Type: {poke.type}</li>
          <li>Attack: {poke.attack}</li>
          <li>Defense: {poke.defense}</li>
          <li>Moves: {poke.moves}</li>
        </ul>
      </div>
    );
  };
}

export default PokemonDetail
