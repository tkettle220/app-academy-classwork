Array.prototype.myEach = function(callback) {
  for(let i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

Array.prototype.myMap = function(callback) {
  const result = [];
  this.myEach( (x) => { result.push(callback(x)); } );
  return result;
};


Array.prototype.myReduce = function(callback, initialValue) {
  let copy = this;
  let acc = null;

  if (initialValue) {
    acc = initialValue;
  } else {
    acc = this[0];
    copy = this.slice(1);
  }

  copy.myEach( (el) => { acc = callback(acc, el); });

  return acc;
};
