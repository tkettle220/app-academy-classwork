import TodoDetailViewContainer from './todo_detail_view_container';

import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      hidden: true
    };

    this.id = this.props.todo.id;
    this.title = this.props.todo.title;

    this.displayHidden = this.displayHidden.bind(this);
    this.showMore = this.showMore.bind(this);

    this.displayStatus = this.displayStatus.bind(this);
    this.removeClick = this.removeClick.bind(this);
    this.clickDone = this.clickDone.bind(this);
  }

  removeClick() {
    this.props.deleteTodo(this.id);
  }

  clickDone() {
    let { done } = this.props.todo;

    if (done) {
      this.props.todo.done = false;
    } else {
      this.props.todo.done = true;
    }

    this.props.updateTodo(this.props.todo);
  }

  showMore() {
    let { hidden } = this.state;

    if (hidden) {
      this.setState({hidden: false});
    } else {
      this.setState({hidden: true});
    }
  }

  displayHidden() {
    let { hidden } = this.state;

    if (hidden) {
      return "Show More";
    } else {
      return "Hide";
    }
  }

  displayStatus() {
    if (this.props.todo.done) {
      return "Undo";
    }
    else {
      return "Done";
    }
  }

  render() {
    let detail = "";

    if (!this.state.hidden) {
      detail = <TodoDetailViewContainer todo={this.props.todo}/>;
    }

    return (
      <li>{this.title}
        <button onClick={this.removeClick} >Delete</button>
        <button onClick={this.clickDone}>{this.displayStatus()}</button>
        <button onClick={this.showMore}>{this.displayHidden()}</button>
        {detail}
     </li>

    );
  }
}

export default TodoListItem;
