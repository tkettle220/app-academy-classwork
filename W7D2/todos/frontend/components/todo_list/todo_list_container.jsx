import {connect} from 'react-redux';
import TodoList from './todo_list';
import {allErrors, allTodos} from '../../reducers/selectors';
import {removeTodo, updateTodo, fetchTodos, createTodo, deleteTodo}
        from '../../actions/todo_actions';

const mapStateToProps = state => ({
  todos: allTodos(state),
  errors: allErrors(state)
});

const mapDispatchToProps = dispatch => ({
  createTodo: (todo) => dispatch(createTodo(todo)),
  deleteTodo: (id) => dispatch(deleteTodo(id)),
  updateTodo: (id) => dispatch(updateTodo(id)),
  fetchTodos: () => dispatch(fetchTodos())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
