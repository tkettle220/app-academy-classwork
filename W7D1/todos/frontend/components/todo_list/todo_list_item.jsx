import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.id = this.props.todo.id;
    this.title = this.props.todo.title;
  }

  render() {
    return (
      <li>{this.title}
        //need to change onclick to a callback
        <button onClick={this.props.removeTodo(this.id)} >Delete</button> </li>
    );
  }
}

export default TodoListItem;
