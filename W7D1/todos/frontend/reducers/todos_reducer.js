import {RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO} from "../actions/todo_actions";



const initialState = {
  1: {
    id: 1,
    title: 'wash car',
    body: 'with soap',
    done: false
  },
  2: {
    id: 2,
    title: 'wash dog',
    body: 'with shampoo',
    done: true
  },
};

const todosReducer = (oldState = initialState, action) => {
  // debugger;
  console.log(action);
  switch (action.type) {

    case RECEIVE_TODOS:
      let newState = {};
      //foreach?
      action.todos.each((todo)=>{
        newState[todo.id] = todo;
      });
      return newState;
    case RECEIVE_TODO:
      const todo = action.todo;
      let todoState = {};
      todoState = Object.assign(todoState, oldState);
      todoState[todo.id] = todo;
      console.log(todoState);
      return todoState;
    case REMOVE_TODO:
      let todoState2 = {};
      todoState = Object.assign(todoState2, oldState);
      delete todoState2[action.id];
      return todoState2;
    default:
      return oldState;

  }
};

export default todosReducer;
