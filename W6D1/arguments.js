function sum1(...args) {
  let sum = 0;
  args.forEach( el => {sum += el;});
  return sum;
}

function sum2() {
  let sum = 0;
  let args = Array.from(arguments);
  args.forEach( el => {sum += el;});
  return sum;
}

Function.prototype.myBind = function myBind(context, ...bindArgs) {
  return  (...callArgs) => {
    let allArgs = bindArgs.concat(callArgs);
    this.apply(context, allArgs);
  };
};

function curriedSum(numArgs) {
  let numbers = [];

  function _curriedSum(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return sum1(...numbers);
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;


}

// spread curry
Function.prototype.curry = function curry(numArgs) {
  let args = [];
  let origFunc = this;

  function _curried(num) {
    args.push(num);
    if (args.length === numArgs) {
      return origFunc(...args);
    } else {
      return _curried;
    }
  }
  return _curried;
};

// apply curry
Function.prototype.curry = function curry(numArgs) {
  let args = [];
  let origFunc = this;

  function _curried(num) {
    args.push(num);
    if (args.length === numArgs) {
      return origFunc.apply(this, args);
    } else {
      return _curried;
    }
  }
  return _curried;
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

// you'll write `Function#curry`!
let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
f1 = f1(6); // = 30

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6)); // == 30
