import React from 'react';

class Calculator extends React.Component {
  constructor(props) {
    super(props);
    this.state = {result: 0, num1: "", num2: ""};
    this.setNum1 = this.setNum1.bind(this);
    this.setNum2 = this.setNum2.bind(this);
    this.add = this.add.bind(this);
    this.sub = this.sub.bind(this);
    this.mult = this.mult.bind(this);
    this.div = this.div.bind(this);
    this.clear = this.clear.bind(this);
  }

  setNum1(e) {
    const num1 = e.target.value ? parseInt(e.target.value) : "";
    this.setState({num1});
  }

  setNum2(e) {
    const num2 = e.target.value ? parseInt(e.target.value) : "";
    this.setState({num2});
  }

  add(e){
    e.preventDefault();
    const result = this.state.num1 + this.state.num2;
    this.setState({ result });
  }

  sub(e){
    e.preventDefault();
    const result = this.state.num1 - this.state.num2;
    this.setState({ result });
  }

  mult(e){
    e.preventDefault();
    const result = this.state.num1 * this.state.num2;
    this.setState({ result });
  }

  div(e){
    e.preventDefault();
    const result = this.state.num1 / this.state.num2;
    this.setState({ result });
  }

  clear(e){
    e.preventDefault();
    this.setState({ num1: "", num2: "", result: 0 });
  }




  render() {
    const {num1, num2, result} = this.state;
    return (
      <div>
        <h1>Calculator</h1>
        <input onChange= {this.setNum1} value ={num1}/>
        <input onChange = {this.setNum2} value ={num2}/>
        <button onClick={this.add}>Add</button>
        <button onClick={this.sub}>Subtract</button>
        <button onClick={this.mult}>Multiply</button>
        <button onClick={this.div}>Divide</button>
        <button onClick={this.clear}>Clear!</button>
        <h1>Result: {result}</h1>
      </div>
    );
  }
}

export default Calculator;
