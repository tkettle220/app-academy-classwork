const Game = require('./game.js');

const GameView = function GameView(ctx) {
  this.ctx = ctx;
  this.game = new Game();
};

GameView.prototype.start = function start() {
  this.game.draw(this.ctx);

  setInterval( () => {
    this.game.step();
    this.game.draw(this.ctx);
  }, 20);
};

GameView.prototype.bindKeyHandlers = function bindKeyHandlers(){
  
};

module.exports = GameView;
