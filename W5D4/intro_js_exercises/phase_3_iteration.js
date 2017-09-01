Array.prototype.bubbleSort = function() {
  let dup = this;
  let sorted = false;
  while(!sorted) {
    sorted = true;
    for(let i = 0; i < this.length - 1; i++){
      let j = i + 1;
      if(dup[i] > dup[j]){
        let temp = dup[i];
        dup[i] = dup[j];
        dup[j] = temp;
        sorted = false;
      }
    }
  }
  return dup;
};

String.prototype.substrings = function() {
  const arr = [];
  for(let i = 0; i < this.length; i++){
    for(let j = i + 1; j < this.length + 1; j++){
      arr.push(this.slice(i,j));
    }
  }

  return arr;
};
