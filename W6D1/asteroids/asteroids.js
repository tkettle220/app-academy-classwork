
const GameView = require('./lib/game_view.js');

function startGame() {
  const canvasEl = document.getElementsByTagName("canvas")[0];
  canvasEl.height = 500;
  canvasEl.width = 500;
  new GameView(
    canvasEl.getContext("2d")
  ).start();
}

document.addEventListener('DOMContentLoaded', startGame);
