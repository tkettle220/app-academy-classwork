class Board
  attr_accessor :grid

  def initialize(grid = Board.blank_grid)
    @grid = grid
  end

  def self.blank_grid
    Array.new(9) {Array.new(9) { Tile.new } }
  end

  def seed_randomly
    sample_arr = (0...100).to_a
    grid.each do |row|
      row.each do |tile|
        rand_val = sample_arr.sample
        tile.bomb = true if rand_val < 20
      end
    end
  end

  def all_safe_revealed?
    grid.each do |row|
      row.each do |tile|
        return false if tile.bomb == false && tile.reveal == false
      end
    end
    true
  end

end

  def neighbor_positions(pos)
    row,col = pos
    positions = []
    positions << [row - 1, col - 1] << [row - 1, col] << [row - 1, col + 1]
    positions << [row, col - 1] << [row, col + 1] << [row + 1, col - 1]
    positions << [row + 1, col] << [row + 1, col + 1]
    positions.reject do |pos|
      x,y = pos
      (x > 8 || y > 8) || (x < 0 || y < 0)
    end
    positions
  end

  def set_neighbor_count
    grid.each_with_index do |row, row_index|
      row.each_with_index do |tile, col_index|
        pos = [row_index, col_index]
        bomb_count = 0
        neighbor_positions(pos).each do |n_pos|
          bomb_count += 1 if grid[n_pos].bomb
        end
        tile.num_neighboor_bombs = bomb_count
      end
    end
  end




class Game

  def won?
    board.all_safe_revealed?
  end


end




class Tile

  attr_accessor :reveal, :flag, :bomb, :num_neighboor_bombs

  def initialize
    @reveal = false
    @flag = false
    @bomb = false
    @num_neighboor_bombs = 0
  end
end


class Player

end
