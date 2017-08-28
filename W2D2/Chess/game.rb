require_relative "display.rb"
require_relative "player.rb"

class Game


  def initialize(board, display, player1, player2)
    @board = board
    @display = display
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def play
    until game_over
      @current_player.play_turn
      switch
    end
  end

  def game_over
    @board.checkmate?(:black) || @board.checkmate?(:white)
  end

  def switch
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end



end

if $PROGRAM_NAME == __FILE__
  b = Board.new
  d = Display.new(b)
  p1 = Player.new("Tommy", d, :white)
  p2 = Player.new("Tk", d, :black)
  g = Game.new(b, d, p1, p2)
  g.play
end
