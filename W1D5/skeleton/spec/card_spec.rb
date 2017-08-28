require "rspec"
require "card"

describe Card do
  describe "#initialize" do
    it "detects bad initialization arguments" do
      expect { Card.new(nil, nil) }.to raise_error
      expect { Card.new(:fake_suit, :three) }.to raise_error
      expect { Card.new(:clubs, "z3") }.to raise_error
    end

    it "creates a card with good input" do
      Card.suits.each do |suit|
        Card.values.each do |value|
          card = Card.new(suit, value)

          expect(card).to be_instance_of(Card)
          expect(card.suit).to eq(suit)
          expect(card.value).to eq(value)
        end
      end
    end
  end

  describe "::all_cards" do
    it "returns all cards without duplicates" do
      uniq_cards = Card.all_cards
        .map { |card| [card.suit, card.value] }
        .uniq
        .count
      expect(uniq_cards).to eq(52)
    end
  end
end
