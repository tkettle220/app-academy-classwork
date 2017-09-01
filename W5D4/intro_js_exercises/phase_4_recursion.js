const range = function range(start, end) {
  if (start === end) {
    return [end];
  }
  let result = range(start + 1, end);
  result.unshift(start);
  return result;
};

const sumRec = function sumRec(arr) {
  if (arr.length === 1) {
    return arr[0];
  }

  return arr[0] + sumRec(arr.slice(1));
};

const exponent = function exponent(base, exp) {
  if (exp === 0) {
    return 1;
  }
  if (exp === 1) {
    return base;
  }
  if (exp % 2 === 0) {
    return Math.pow((exponent(base, exp/2)), 2) ;
  } else {
    return base * Math.pow(exponent(base, ((exp-1)/2)), 2 ) ;
  }
};

const fib = function fib (n) {
  if (n === 1) {
    return [1];
  }
  if (n === 2) {
    return [1,1];
  }
  let prevFib = fib(n-1);
  prevFib.push(prevFib[prevFib.length-1] + prevFib[prevFib.length-2]);
  return prevFib;
};

const bsearch = function bsearch (arr, target) {
  const midIndex = Math.floor((arr.length-1) / 2);

  if (arr.length === 1 && arr[0] !== target) {
    return -1;
  }

  if (arr[midIndex] === target) {
    return midIndex;
  }

  if (arr[midIndex] > target) {
    return bsearch(arr.slice(0, midIndex), target);
  }

  if (arr[midIndex] < target) {
    const result = bsearch(arr.slice(midIndex + 1), target);
    if (result !== -1) {
      return result + 1 + midIndex;
    } else {
      return -1;
    }

  }
};

const mergesort = function mergesort(arr) {
  const merge = function merge(left, right) {
    const result = [];
    while(left.length > 0 && right.length > 0) {
      if(left[0] <= right[0]) {
        result.push(left.shift());
      } else {
        result.push(right.shift());
      }
    }
    return result.concat(left.concat(right));
  };
  if(arr.length <= 1) {
    return arr;
  }

  let left = arr.slice(0, arr.length / 2);
  let right = arr.slice(arr.length / 2);

  let sortedLeft = mergesort(left);
  let sortedRight = mergesort(right);
  return merge(sortedLeft, sortedRight);
};

const subsets = function subsets(arr) {
  if (arr.length === 0) {
    return [arr];
  }

  let prevSubsets = subsets(arr.slice(1));

  let result = prevSubsets.map(function(el) {
    let elCopy = el.slice();
    elCopy.push(arr[0]);
    return elCopy;
  });
  return prevSubsets.concat(result);
};
