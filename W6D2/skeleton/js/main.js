const View = require('./ttt-view');
const Game = require('./solution/game');

$( () => {
  const game = new Game();
  const $container = $(".ttt");
  console.log($container);
  const view = new View(game, $container);
  view.bindEvents();
});
