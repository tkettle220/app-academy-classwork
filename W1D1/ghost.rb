require 'byebug'

class Game
  attr_accessor :players, :fragment, :dict, :current_player
  def initialize(dict, *players)
    @players = players
    @fragment = ""
    @dict = dict
    @current_player = players.first
  end

  def play_game
    until won?
      play_round
    end
    puts "#{players.first}, wins!"
  end

  def won?
    players.count == 1
  end

  def play_round
    @fragment += take_turn(current_player)
    next_player!
  end

  def next_player!
    idx = (players.find_index(current_player) + 1) % players.length
    @current_player = players[idx]
  end

  def take_turn(player)
    lost = false
    letter = player.get_letter
    until valid_play?(fragment + letter)
      puts "Invalid Play!"
      current_player.lives -= 1
      puts "#{player.name} has #{player.lives} lives left"
      if current_player.lost?
        lost = true
        remove_player(current_player)
        next_player!
        break
      else
        letter = player.get_letter
      end
    end
    p "letter: #{letter}"
    @fragment += letter unless lost
  end

  def remove_player(player)
    players.reject! { |p1| p1.name == player.name }
  end

  def valid_play?(string)
    p string
    dict.any? { |w| is_substr?(string, w) }
  end
end

def is_substr?(sub_str, string)
  string[0...sub_str.length] == sub_str
end


class Player
  attr_accessor :name, :lives

  def initialize(name)
    @name = name
    @lives = 5
  end

  def get_letter
    puts "#{name}, please input letter: "
    gets.chomp
  end

  def lost?
    lives == 0
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Enter players: [name, name, name..]"
  player_names = gets.chomp.split(' ')
  player_arr = player_names.map {|player| Player.new(player) }
  dict = IO.readlines('dictionary.txt').map(&:chomp)

  game = Game.new(dict, *player_arr)
  # debugger
  game.play_game
end
