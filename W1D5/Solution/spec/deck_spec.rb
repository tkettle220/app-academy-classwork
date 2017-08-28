require "rspec"
require "card"
require "deck"

describe Deck do
  let(:cards) do
    [
      double("card", value: :king),
      double("card", value: :queen),
      double("card", value: :jack)
    ]
  end

  let(:more_cards) do
    [
      double("card", value: :four),
      double("card", value: :five),
      double("card", value: :six)
    ]
  end

  let(:deck) { Deck.new(cards) }

  let(:full_deck) { Deck.new }

  describe "#initialize" do
    context "when passed an array of cards" do
      it "initializes with the passed-in array" do
        expect(deck.count).to eq(3)
      end
    end

    context "when not passed arguments" do
      it "builds a deck of 52 cards" do
        expect(full_deck.count).to eq(52)
      end
    end
  end

  describe "#deal" do
    let!(:duped_cards) { cards.dup }

    # **treat the front of the cards array as the top**
    it "deals cards from the top of the deck" do
      expect(deck.deal(1)).to eq(duped_cards[0..0])
      expect(deck.deal(2)).to eq(duped_cards[1..2])
    end

    it "removes cards from the deck" do
      deck.deal(2)

      expect(deck.count).to eq(1)
    end
  end

  describe "#empty?" do
    let(:empty_deck) { Deck.new([]) }

    context "when there are no cards in the deck" do
      it "returns true" do
        expect(empty_deck.empty?).to be_truthy
      end
    end

    context "when there are cards in the deck" do
      it "returns false" do
        expect(deck.empty?).to be_falsey
      end
    end
  end

  describe "#count" do
    it "returns the number of cards in the deck" do
      expect(deck.count).to eq(3)
      expect(full_deck.count).to eq(52)
    end
  end

  describe "#receive" do
    let!(:more_cards_dup) { more_cards.dup }

    before(:each) { deck.receive(more_cards) }

    it "adds the received cards to the deck" do
      expect(deck.count).to eq(6)
    end

    it "does not modify the passed array" do
      expect(more_cards_dup).to eq(more_cards)
    end

    it "adds the received cards to the bottom of the deck" do
      deck.deal(3) # toss 3 cards away

      expect(deck.deal(1)).to eq(more_cards[0..0])
      expect(deck.deal(1)).to eq(more_cards[1..1])
      expect(deck.deal(1)).to eq(more_cards[2..2])
    end
  end
end
