class Hand
  attr_reader :books, :cards

  def initialize(cards = [])
    @books = 0
    @cards = cards
  end

  def include?(value)
    @cards.any? {|card| card.value == value }
  end

  def empty?
    @cards.empty?
  end

  def count
    @cards.length
  end

  def give_up(value)
    arr = []
    if include?(value)
      arr = []
      @cards.each do |card|
        arr << card if card.value == value
      end
      @cards.delete_if {|card| card.value == value}
    end
    arr
  end

  def receive(new_cards)
    new_cards.each {|card| @cards << card}
  end

  # This method isn't tested, but we strongly recommend you implement it as a
  # helper method. It should return a hash mapping values to the number of
  # matching cards in the hand (e.g., { king: 2, deuce: 3 })
  def count_sets
    counter = Hash.new(0)
    @cards.each do |card|
      counter[card.value] += 1
    end
    counter
  end

  def play_books
    counter = count_sets
    counter.each do |value, count|
      if count == 4
        @books += 1
        @cards.delete_if{|card| card.value == value}
      end
    end
  end
end
