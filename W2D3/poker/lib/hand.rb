require_relative "deck"

class Hand

  def initialize(deck)
    5.times { @cards << deck.draw }
    @cards.sort!
  end

  private

  def one_pair(hand_arr)
    seen_cards = []
    hand_arr.each do |crd|
      return crd.value if seen_cards.include?(crd)
      seen_cards << crd
    end
    nil
  end

  def two_pair(hand_arr)
    first_pair_value = one_pair(hand_arr)
    return nil if first_pair_value.nil?
    hand_subset = @cards.reject { |crd| crd.value == first_pair_value}
    second_pair_value = one_pair(hand_subset)
    return nil if second_pair_value.nil?
    [first_pair_value, second_pair_value]
  end

  def three_of_a_kind(hand_arr)
    pair_value = one_pair(hand_arr)
    return nil if pair_value.nil?
    hand_subset = hand_arr.select { |crd| crd.value == pair_value }
    return nil if hand_subset.length != 3
    pair_value
  end

  def straight
    if @cards.last.value - @cards.first.value == 4
      @cards.last.value
    end
  end

  def flush
    if @cards.all?{ |crd| crd.suit == @cards.first.suit }
      @cards.last.value
    end
  end

  def full_house(hand_arr)
    triple_value = three_of_a_kind(hand_arr)
    return nil if triple_value.nil?
    hand_subset = @cards.reject { |crd| crd.value == triple_value}
    pair_value = one_pair(hand_subset)
    return nil if pair_value.nil?
    [triple_value, pair_value]
  end

  def four_of_a_kind(hand_arr)
    pair_value = one_pair(hand_arr)
    return nil if pair_value.nil?
    hand_subset = hand_arr.select { |crd| crd.value == pair_value }
    return nil if hand_subset.length != 4
    pair_value
  end

  def straight_flush
    straight && flush
  end









end
