import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component{
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.fetchTodos();
  }

  render() {
    return (
      <div>
        <ul>
          {this.props.todos.map(
            (todo) => <TodoListItem
            key={todo.id} todo={todo}
            deleteTodo={this.props.deleteTodo}
            updateTodo={this.props.updateTodo}/>
          )}
        </ul>

        <TodoForm
          createTodo={this.props.createTodo}
          receiveErrors={this.props.receiveErrors}
          allErrors={this.props.errors}
          />
      </div>
    );
  }
}

export default TodoList;
