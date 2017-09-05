class View {
  constructor(game, $el) {
    const $board = this.setupBoard();
    $el.append($board);
    this.game = game;

  }

  bindEvents() {
    const $listItems = $("li");
    $listItems.on("click", event => {
      const currentTarget = event.currentTarget;
      this.makeMove(currentTarget);
    });
  }

  makeMove($square) {
    const mark = this.game.currentPlayer;
    $($square).addClass(`${mark}`);
    const moveStr = $($square).attr("id");
    const move = [moveStr[0], moveStr[2]];
    $($square).text(mark);
    this.game.playMove(move);
    $($square).css("background-color", "white");
    if(this.game.isOver()) {
      //winner squares background to green, text to white
      //loser squares text to red
      //loser and empty square set to white
      const winner = this.game.winner();
      console.log(winner);
      const $allSquares = $('li');
      let $winnerSquares = [];
      if (winner === 'x') {
        console.log(1);
        $winnerSquares = $(".x");
      } else if (winner === 'o') {
        $winnerSquares = $(".o");
      }
      $allSquares.css("background-color", "white");
      $allSquares.css("color", "red");
      $allSquares.css("border-color", "black");
      $winnerSquares.css("background-color", "green");
      $winnerSquares.css("color", "white");

      alert("Game is over");
    }
  }

  setupBoard() {
    const $ul = $("<ul></ul>");
    $ul.attr("style", "width: 700px");
    for(let i = 0; i < 9; i ++) {
      let $li = $("<li></li>");
      $li.attr("style", "list-style: none; float: left; background-color: gray; border-style: double; width: 200px; height: 200px; font-size: 60px");

      $li.mouseenter(function() {
        if( $(this).css("background-color") !== "rgb(255, 255, 255)" ) {
          $(this).css("background-color", "yellow");
        }
      });
      $li.mouseleave(function() {
        console.log($(this).css("background-color"));
        if( $(this).css("background-color") !== "rgb(255, 255, 255)" ) {
          $(this).css("background-color", "gray");
        }

      });
      const processIdx = function processIdx (idx) {
        let pos = [];
        pos.push(Math.floor(i/3));
        pos.push(i % 3);
        return pos;
      };
      $li.attr("id", processIdx(i) );

      $ul.append($li);
    }
    return $ul;
  }
}

module.exports = View;
