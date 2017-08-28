require_relative "player.rb"

class Game
  attr_reader :deck, :players

  def initialize(players, deck = Deck.new, deal = true)
    @deck = deck
    @players = players
  end

  def deal_players_in
    # DO NOT MODIFY
    players.each { |player| player.take(deck.deal(7)) }
  end

  # switch the current player
  def next_player!
    @players.rotate!
  end

  def current_player
    @players.first
  end

  # returns all non-current players
  def other_players
    @players[1..-1]
  end

  def play
    until game_over?
      play_turn
    end

    puts "#{winner.name} wins!"
  end

  # If the current player receives cards, they take another turn (that is, this
  # method returns without passing the turn to the next player). Otherwise, the
  # current player has to "go fish" and the turn passes to the next player.
  def play_turn
    request = current_player.make_request
    value, target = request
    if target.has_value?(value)
      give_up = target.give_up(value)
      current_player.take(give_up)
    else
      current_player.go_fish(deck)
      next_player!
    end
  end

  def game_over?
    deck.empty? && @players.none?{|player| player.in_play?}
  end

  def winner
    game_winner = players.first
    players[1..-1].each do |player|
      game_winner = player if player.books > game_winner.books
    end
    game_winner
  end
end
