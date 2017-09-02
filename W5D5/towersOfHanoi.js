const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


class Game {
  constructor () {
    this.stacks = [[3,2,1],[],[]];
  }

  promptMove () {
    this.print();
    const toStack = function toStack(fromStackStr) {
      reader.question("To which stack? ", (toStackStr) => {
        const fromStackIndex = parseInt(fromStackStr);
        const toStackIndex = parseInt(toStackStr);
        console.log(`From stack: ${fromStackIndex}`);
        console.log(`To stack: ${toStackIndex}`);
        return [fromStackIndex, toStackIndex];
      } );
    };
    reader.question("From which stack? ", (ans) => toStack(ans) );
  }

  isValidMove (startTowerIdx, endTowerIdx) {
    if (this.stacks[startTowerIdx].length === 0 ) {
      return false;
    } else if (this.stacks[endTowerIdx].length === 0 ) {
      return true;
    }

    const startTowerLastIdx = this.stacks[startTowerIdx].length - 1;
    const endTowerLastIdx = this.stacks[endTowerIdx].length - 1;
     return this.stacks[startTowerIdx][startTowerLastIdx]
      < this.stacks[endTowerIdx][endTowerLastIdx];
  }

  move (startTowerIdx, endTowerIdx) {
    if (this.isValidMove(startTowerIdx, endTowerIdx)) {
      this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
      return true;
    } else {
      return false;
    }
  }

  print () {
    console.log(JSON.stringify(this.stacks));
  }

  isWon () {
    return this.stacks[1].length === 3 || this.stacks[2].length === 3;
  }

  run (completionCallback) {
    const [fromStackIndex, toStackIndex] = this.promptMove();
    this.move(fromStackIndex, toStackIndex);
    if(this.isWon()){
      return completionCallback();
    } else {
      this.run(completionCallback);
    }
  }
}

const game = new Game();
game.run(() => console.log("Won!") );


// Game.prototype.run = function run() {
  //until all of the discs are moved into column two
    //or all into column three.
      //render the board.
      //get move from current player until a valid move is given.
      //make move on the board.

  //print completion statement.
// };
