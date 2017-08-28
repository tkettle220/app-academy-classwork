require_relative "card"

class Deck
  attr_reader :cards

  def initialize
    @cards = generate_deck.shuffle

  end

  SUITS = [:hearts, :spades, :diamonds, :clubs].freeze


  def draw
    raise "Not enough cards!" if @cards.empty?
    @cards.pop
  end

  private

  def generate_deck
    cards = []
    (2..14).each do |num|
      SUITS.each do |suit|
        cards << Card.new(num, suit)
      end
    end
    cards
  end

end
