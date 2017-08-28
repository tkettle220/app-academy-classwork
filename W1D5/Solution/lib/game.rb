class Game
  attr_reader :deck, :players

  def initialize(players, deck = Deck.new, deal = true)
    # ...
    @deck = deck
    @players = players
    deal_players_in if deal

  end

  def deal_players_in
    # DO NOT MODIFY
    players.each { |player| player.take(deck.deal(7)) }
  end

  # switch the current player
  def next_player!
    first_player = @players.shift
    @players << first_player
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
    value, target = current_player.make_request(other_players)
    if target.has_value?(value)
      current_player.take(target.give_up(value))
      # play_turn
    else
      current_player.go_fish(@deck)
      next_player!
    end
  end

  def game_over?
    someone_is_still_playing = @players.any? do |player|
      player.in_play?
    end
    !someone_is_still_playing && @deck.empty?
  end

  def winner
    max_book = 0
    curr_winner = current_player
    @players.each do |player|
      if player.books > max_book
        max_book = player.books
        curr_winner = player
      end
    end
    curr_winner
  end
end
