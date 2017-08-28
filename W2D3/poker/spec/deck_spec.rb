require "rspec"
require "deck"

describe "Deck" do
  subject(:example_deck) { Deck.new }
  describe "#initialize" do
    it "holds cards in array" do
      expect(example_deck.cards).to be_an(Array)
    end
    it "contains 52 cards" do
      expect(example_deck.cards.length).to eq(52)
      expect(example_deck.cards.all? { |el| el.class == Card }).to be true
    end
    it "contains no dups" do
      drawn_card = example_deck.cards.pop
      expect(example_deck.cards.none? do |el|
        el.value == drawn_card.value && el.suit == drawn_card.suit
      end).to be true
    end
  end

  describe "#draw" do
    let(:drawn_card) { example_deck.draw }
    it "removes one card" do
      example_deck.draw
      expect(example_deck.cards.length).to eq(51)
    end
    it "returns a card" do
      expect(drawn_card).to be_a(Card)
    end
    it "throws error if deck is empty" do
      expect { 53.times { example_deck.draw } }.to raise_error("Not enough cards!")
    end
  end
end
