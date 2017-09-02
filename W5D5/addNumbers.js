const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const addNumbers = function addNumbers(sum, numsLeft, completionCallback) {

  const addNum = function addNum(num) {
    let theNum = parseInt(num);
    sum += theNum;
    console.log(`The sum is: ${sum}`);
    addNumbers(sum, numsLeft - 1, completionCallback);
  };

  if (numsLeft > 0) {
    reader.question("Input a number: ", (num) => addNum(num) );
  } else {
    completionCallback(sum);
    reader.close();
    return;
  }
};

addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
