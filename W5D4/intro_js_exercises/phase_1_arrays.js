Array.prototype.uniq = function() {
  const seen = [];
  this.forEach(
    (el) => {if(!seen.includes(el)) {
      seen.push(el);
    }}
  );
  return seen;
};

Array.prototype.twoSum = function () {
  const pairs = [];
  for(let i = 0; i < this.length - 1; i++) {
    for(let j = (i + 1); j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        pairs.push([i, j]);
      }
    }
  }

  return pairs;
};

Array.prototype.transpose = function () {
  // const matrix = new Array(this[0].length);
  const matrix = [];
  for(let i = 0; i < this.length-1; i++ ){
    matrix.push(new Array(this.length));
  }

  for(let i = 0; i < matrix.length; i++){
    for(let j = 0; j < matrix[0].length; j++) {
      matrix[i][j] = this[j][i];
    }
  }
  return matrix;


};

// [1,2]
// [3,4]
// [5,6]

// [1,3,5]
// [2,4,6]
