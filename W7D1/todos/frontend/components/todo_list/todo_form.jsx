import React from 'react';
const uniqueId = require('../../util/utils');

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      id: uniqueId(),
      title: "",
      body: "",
      done: false
    };

    this.createTodo = this.createTodo.bind(this);
    this.linkState = this.linkState.bind(this);
  }

  linkState(key) {
    return (event => this.setState({[key]: event.currentTarget.value}));
  }

  createTodo(e) {
    console.log(this.props.receiveTodo);
    e.preventDefault();
    this.props.receiveTodo(this.state);
    this.setState({
      id: uniqueId(),
      title: "",
      body: "",
      done: false
    });
  }

  render(){
    return (
      <form>

        <label>Title:
          <input onChange={this.linkState('title')} value={this.state.title} />
        </label>

        <label>Body:
          <input onChange={this.linkState('body')} value={this.state.body} />
        </label>

        <button onClick={this.createTodo}>Submit</button>

      </form>
    );
  }

}

export default TodoForm;
