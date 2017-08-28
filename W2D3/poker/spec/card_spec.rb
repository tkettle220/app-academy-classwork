require "rspec"
require "card"

describe "Card" do
  subject(:example_card) { Card.new(2, :clubs) }
  subject(:small_card) { Card.new(2, :diamonds) }
  subject(:big_card) { Card.new(10, :clubs) }

  describe "#initialize" do
    it "initializes with correct number" do
      expect(example_card.value).to eq(2)
    end
    it "initializes with correct suit" do
      expect(example_card.suit).to eq(:clubs)
    end
  end

  describe "comparisons" do
    it "== returns true if card values are equal" do
      expect(example_card == small_card).to be true
    end
    it "== returns false if card values are not equal" do
      expect(big_card == small_card).to be false
    end
    it "> returns true if first card value is larger" do
      expect(big_card > small_card).to be true
    end
    it "> returns false if second card value is larger" do
      expect(small_card > big_card).to be false
    end

  end

end
