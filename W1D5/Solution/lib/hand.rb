class Hand
  attr_reader :books, :cards

  def initialize(cards = [])
    @cards = cards
    @books = 0
  end

  def include?(value)
    @cards.any? do |card|
      card.value == value
    end
  end

  def empty?
    @cards.empty?
  end

  def count
    @cards.length
  end

  def give_up(value)
    giveup_arr = []
    @cards.dup.each do |card|
      if card.value == value
        giveup_arr << card
        @cards.delete(card)
      end
    end
      giveup_arr
  end

  def receive(new_cards)
    @cards += new_cards
  end

  # This method isn't tested, but we strongly recommend you implement it as a
  # helper method. It should return a hash mapping values to the number of
  # matching cards in the hand (e.g., { king: 2, deuce: 3 })
  def count_sets
    hash_set = Hash.new {0}
    @cards.each do |card|
      hash_set[card.value] += 1
    end
    hash_set
  end

  def play_books
    count_sets.each do |value, count|
      if count == 4
        @books += 1
        give_up(value)
      end
    end
  end
end
