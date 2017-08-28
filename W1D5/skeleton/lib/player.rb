require_relative "hand.rb"

class Player
  attr_reader :hand, :name

  def initialize(name, hand = Hand.new)
    @name = name
    @hand = hand
  end

  def books
    hand.books
  end

  def take(cards)
    hand.receive(cards)
    play_books
  end

  def give_up(value)
    hand.give_up(value)
  end

  def has_value?(value)
    @hand.cards.each {|card| return true if card.value == value}
    false
  end

  def go_fish(deck)
    card_arr = deck.deal(1)
    take(card_arr)
  end

  def play_books
    hand.play_books
  end

  # returns a value and a target player
  def make_request(other_players)
    value = choose_value
    target = choose_player(other_players)
    [value, target]
  end

  def in_play?
    !@hand.empty?
  end

  # Don't implement these last two methods; normally we would define these
  # inside of HumanPlayer and ComputerPlayer classes.

  def choose_player(other_players)
    # DO NOT IMPLEMENT
  end

  def choose_value
    # DO NOT IMPLEMENT
  end
end
