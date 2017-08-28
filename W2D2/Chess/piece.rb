require_relative "board.rb"
require "singleton"
require "byebug"

class Piece
  attr_accessor :position, :color, :board

  def initialize(pos, color, board)
    @board = board
    @position = pos
    @color = color
  end

  def update_pos(pos)
    @position = pos
  end

  def array_addition(arr1, arr2)
    arr = []
    arr1.each_with_index do |el, idx|
      arr << el + arr2[idx]
    end
    arr
  end

end

module SlidingPiece
  def valid_move?(pos)
    moves.include?(pos)
  end

  def moves
    array = []

    move_dir.each do |vector|
      array += one_direction(vector)
    end

    array
  end

  def one_direction(vector)
    array = []
    new_pos = position

    while true
      pos = array_addition(vector, new_pos)

      if !Board.in_bounds?(pos) || board[pos].color == color
        # puts "Hit barrier!"
        break
      elsif board[pos].color != color && !board[pos].is_a?(NullPiece)
        # puts "Hit opponent piece!"
        array << pos
        break
      else
        # puts "Hit empty square"
        array << pos
        new_pos = pos
      end
    end
    array.sort
  end

end

module SteppingPiece

  def valid_move?(pos)
    moves.include?(pos) && Board.in_bounds?(pos) && board[pos].color != color
  end

  def moves
    move_arr.map do |move|
      array_addition(position, move)
    end
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
    @color = nil
  end

end

class Bishop < Piece
  include SlidingPiece

  def move_dir
    [[1, 1], [-1, -1 ], [1, -1 ], [-1, 1]]
  end

end

class Rook < Piece
  include SlidingPiece

  def move_dir
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end
end

class Queen < Piece
  include SlidingPiece

  def move_dir
    [[1, 1], [-1, -1], [1, -1], [-1, 1], [0, 1], [0, -1], [1, 0], [-1, 0]]
  end
end

class Knight < Piece
  include SteppingPiece

  def move_arr
     [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
  end
end

class King < Piece
  include SteppingPiece

  def move_arr
    [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [-1, 0], [-1, 1], [-1, -1]]
  end
end

class Pawn < Piece

  def valid_move?(pos)
    moves.include?(pos) && Board.in_bounds?(pos)
  end

  def moves
    arr = []
    home_row = 1

    attack_vector1 = [1,1]
    attack_vector2 = [1,-1]
    step_vector = [1,0]
    first_move_vector = [2,0]
    if color == :white
      home_row = 6
      attack_vector1 = [-1,1]
      attack_vector2 = [-1,-1]
      step_vector = [-1,0]
      first_move_vector = [-2,0]
    end
    step_pos = array_addition(step_vector, position)
    if (board[step_pos].color.nil?)
      arr << step_pos
    end

    attack_pos_1 = array_addition(attack_vector1, position)
    attack_pos_2 = array_addition(attack_vector2, position)
    attack_piece_1 = board[attack_pos_1]
    attack_piece_2 = board[attack_pos_2]

    if Board.in_bounds?(attack_pos_1)
      unless attack_piece_1.is_a?(NullPiece) || attack_piece_1.color == color
        arr << attack_pos_1
      end
    end

    if Board.in_bounds?(attack_pos_2)
      unless attack_piece_2.is_a?(NullPiece) || attack_piece_2.color == color
        arr << attack_pos_2
      end
    end

    if position.first == home_row
      arr << array_addition(first_move_vector, position)
    end
    arr
  end

end
