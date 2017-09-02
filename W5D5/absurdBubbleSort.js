const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const askIfGreaterThan = function askIfGreaterThan(el1, el2, callback) {
  const processInput = function processInput (input) {
    if (input === 'yes') {
      callback(true);
    } else {
      callback(false);
    }
  };

  reader.question(`is ${el1} greater than ${el2}?`,
                 (input) => processInput(input) );
};
//test
// askIfGreaterThan(1,2,(input) => {
//   console.log(`${input}`);
//   reader.close();
//   });

//innerbubblesort
const innerBubbleSortLoop = function innerBubbleSortLoop(arr, i,
                                      madeAnySwaps, outBubbleSortLoop){
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i],arr[i+1],(isGreaterThan) => {
      if (isGreaterThan) {
        [arr[i],arr[i+1]] = [arr[i+1],arr[i]];
        return innerBubbleSortLoop(arr, i + 1, true, outBubbleSortLoop);
      } else {
        return innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outBubbleSortLoop);
      }
    });
  } else {
    return outBubbleSortLoop(madeAnySwaps);
  }
};

// test
// innerBubbleSortLoop([3,2,1], 0, false,
 // () => console.log("In the outer loop"));

const absurdBubbleSort = function absurdBubbleSort(arr,
  sortCompletionCallback) {

  const outerBubbleSortLoop = function outerBubbleSortLoop(madeAnySwaps) {
    if(madeAnySwaps===true) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  };

  outerBubbleSortLoop(true);
};

absurdBubbleSort([3,2,1], (arr) => {
  // console.log(arr);
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
  return;
});
