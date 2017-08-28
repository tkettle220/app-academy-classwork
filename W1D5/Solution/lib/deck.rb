class Deck
  attr_reader :cards

  def initialize(cards = Card.all_cards.shuffle)
    @cards = cards
  end

  def deal(num_cards)
    @cards.shift(num_cards)
  end

  def empty?
    @cards.empty?
  end

  def count
    @cards.length
  end

  def inspect
    "#{cards.map(&:to_s)}"
  end

  def receive(new_cards)
    @cards += new_cards
  end
end
