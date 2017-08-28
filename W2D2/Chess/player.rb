class Player


  def initialize(name, display, color)
    @name = name
    @color = color
    @display = display
  end

  def play_turn
    @display.get_move(@color)
  end

end
