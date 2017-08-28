class Card
  attr_accessor :value, :up

  def initialize(value)
    @value = value
    @up = false
  end

  def display_information
    if up
      puts "Card's value is #{value}"
    end
  end

  def hide
    @up = false
  end

  def reveal
    display_information
    @up = true
  end

end

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(4) { Array.new(4) { nil } }
  end

  def render
    grid.each do |row|
      row.each do |card|
        if card.up
          print card.value
        else
          print "X"
        end
      end
      print "\n"
    end
  end

  def won?
    grid.all? { |row| row.all?(&:up) }
  end

  def reveal(pos)
    grid[pos].reveal
    grid[pos].value
  end

  def populate!
    values = (1..8).to_a + (1..8).to_a
    values.shuffle!
    (0...4).each do |row|
      (0...4).each do |col|
        pos = [row, col]
        self[pos] = Card.new(values.pop)
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end
end

class Game
  attr_accessor :board, :previous_guess, :player, :guessed_position

  def initialize(board, player)
    @board = board
    @previous_guess = nil
    @guessed_position = nil
    @player = player
  end

  def won?
    board.won?
  end

  def play
    until board.won?
      system("clear")
      board.render
      play_move
    end
    "Congratulations, you won!!"
  end

  def play_move
    puts "This is your second move" if previous_guess
    guess = player.prompt
    until guess != guessed_position
      puts "Cannot guess the same position, guess again."
      guess = player.prompt
    end
    make_guess(guess)
  end

  def make_guess(guess)
    current_card = board[guess]
    previous_card = previous_guess
    current_card.reveal
    player.receive_revealed_card(guess, current_card.value)
    if previous_guess
      if board[guess].value == previous_guess.value
        puts "Got a match!"
        player.receive_match(guess, guessed_position)
        sleep(2)
      else
        puts "Not a match!"
        board.render
        sleep(3)
        current_card.hide
        previous_card.hide
      end
      @guessed_position = nil
      @previous_guess = nil
    else
      @previous_guess = current_card
      @guessed_position = guess
    end
  end

end

class HumanPlayer
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def prompt
    puts "Please enter a guess."
    get_input
  end

  def get_input
    guess = gets.chomp.split(" ").map(&:to_i)
    until is_valid?(guess)
      puts "Invalid guess."
      guess = gets.chomp.split(" ").map(&:to_i)
    end
    [guess.first - 1, guess.last - 1]
  end

  def is_valid?(guess)
    return false if guess.any? { |n| n < 1 || n > 4 } || guess.length != 2
    true
  end

  def receive_match(guess, guessed_position); end

  def receive_revealed_card(pos, value); end

end

class ComputerPlayer
  attr_accessor :name, :known_board, :matched_cards, :prev_pos, :prev_val

  def initialize(name)
    @name = name
    @known_board = Hash.new {}
    @matched_cards = []
    @prev_pos = nil
    @prev_val = nil
  end

  def populate(dimension)
    (0...dimension).each do |row|
      (0...dimension).each do |col|
        pos = [row, col]
        known_board[pos] = nil
      end
    end
  end

  def receive_revealed_card(pos, value)
    known_board[pos] = value
  end

  def receive_match(pos1, pos2)
    known_board.delete(pos1)
    known_board.delete(pos2)
  end

  def prompt
    if prev_pos
      if knows_pair_pos
        known_board.each { |key, val| return key if val == prev_val }
      else
        random_guess
      end
    elsif knows_a_match?
      get_matching_pos
    else
      random_guess
    end
  end

  def knows_pair_pos
    known_board.values.include?(prev_val)
  end

  def get_matching_pos
    known_board.each do |pos1, val1|
      known_board.each do |pos2, val2|
        return pos1 if val1 == val2 && pos1 != pos2
      end
    end
  end

  def knows_a_match?
    values = known_board.values
    values.reject!(&:nil?)
    values.uniq != values
  end

  def random_guess
    unseen_pos = []
    known_board.each { |pos, val| unseen_pos << pos if val.nil? }
    unseen_pos.sample
  end

end


if $PROGRAM_NAME == __FILE__
  puts "Enter your name."
  name = gets.chomp
  p1 = HumanPlayer.new(name)
  p2 = ComputerPlayer.new("Bot")
  b = Board.new
  b.populate!
  g = Game.new(b, p2)
  g.play
end
# not updating previous guesses for 2nd guess
