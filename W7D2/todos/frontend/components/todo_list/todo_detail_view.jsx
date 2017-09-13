import React from 'react';

class TodoDetailView extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {return (
    <div>{this.props.todo.body}</div>
    );
  }

}

export default TodoDetailView;
