class Deck
  attr_reader :cards

  def initialize(cards = Card.all_cards.shuffle)
    @cards = cards
  end

  def deal(num_cards)
    arr = []
    num_cards.times { arr << cards.shift }
    arr
  end

  def empty?
    cards.empty?
  end

  def count
    cards.count
  end

  def inspect
    "#{cards.map(&:to_s)}"
  end

  def receive(new_cards)
    new_cards.each do |card|
      @cards << card
    end
  end
end
