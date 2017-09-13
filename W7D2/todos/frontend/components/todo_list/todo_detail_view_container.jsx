import {connect} from "react-redux";
import {removeTodo} from '../../actions/todo_actions';
import TodoDetailView from './todo_detail_view';


const mapDispatchToProps = dispatch => ({
  removeTodo: (id) => dispatch(removeTodo(id))
});

export default connect(null, mapDispatchToProps)(TodoDetailView);
