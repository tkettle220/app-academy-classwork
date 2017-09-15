import { connect } from 'react-redux';
import {requestPokemon} from '../../actions/pokemon_actions';
;import {selectAllPokemon} from '../../reducers/selectors';
import PokemonDetail from './pokemon_detail';

const mapStateToProps = state => ({
  pokemon: state.entities.pokemon
});

const mapDispatchToProps = dispatch => ({
  requestPokemon: (id) => dispatch(requestPokemon(id))
});

const PokemonDetailContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonDetail);

export default PokemonDetailContainer;
