

const APIUtil = {
  getTodos () {
    return $.ajax({
      method: 'GET',
      url: '/api/todos'
    });
  },

  addTodo (todo) {
    return $.ajax({
      method: 'POST',
      url: '/api/todos',
      data: {todo}
    });
  },

  updateTodo (todo) {
    return $.ajax({
      method: 'PATCH',
      url: `/api/todos/${todo.id}`,
      data: {todo}
    });
  },

  removeTodo(id) {
    return $.ajax({
      method: 'DELETE',
      url: `/api/todos/${id}`,
      data: {id}
    });
  }


};



module.exports = APIUtil;
