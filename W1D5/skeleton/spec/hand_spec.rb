require "rspec"
require "card"
require "hand"

describe Hand do
  let(:cards) do
    [
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
    ]
  end

  let(:dup_value_cards) do
    [
      Card.new(:spades, :king),
      Card.new(:diamonds, :king),
      Card.new(:hearts, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
    ]
  end

  let(:hand) do
    Hand.new(cards)
  end

  let(:dup_value_hand) do
    Hand.new(dup_value_cards)
  end

  describe "#initialize" do
    it "can be initialized with an array of cards" do
      expect(hand.count).to eq(3)
    end

    it "initializes books to zero" do
      expect(hand.books).to eq(0)
    end
  end

  describe "#include?" do
    context "when the hand contains matching cards" do
      it "returns true" do
        expect(hand.include?(:king)).to be_truthy
      end
    end

    context "when the hand contains no matching cards" do
      it "returns false" do
        expect(hand.include?(:deuce)).to be_falsey
      end
    end
  end

  describe "#empty?" do
    let(:empty_hand) { Hand.new([]) }

    it "returns true when hand is empty" do
      expect(empty_hand.empty?).to eq(true)
    end

    it "returns false when hand is not empty" do
      expect(hand.empty?).to eq(false)
    end
  end

  describe "#give_up" do
    context "when the hand contains the given value" do
      it "returns matching cards" do
        cards = dup_value_hand.give_up(:king)

        expect(cards.count).to eq(3)
        expect(cards.all? { |card| card.value == :king }).to be_truthy
      end

      it "removes matching cards from the hand" do
        hand.give_up(:king)
        dup_value_hand.give_up(:king)

        expect(hand.count).to eq(2)
        expect(dup_value_hand.count).to eq(2)
      end
    end

    context "when the hand does not contain the given value" do
      it "returns an empty array" do
        cards = hand.give_up(:deuce)

        expect(cards).to eq([])
      end
    end
  end

  describe "#receive" do
    let!(:more_cards) do
      [
        Card.new(:hearts, :four),
        Card.new(:hearts, :five),
        Card.new(:hearts, :six)
      ]
    end

    let!(:more_cards_dup) { more_cards.dup }

    before(:each) { hand.receive(more_cards) }

    it "adds cards to the hand" do
      expect(hand.count).to eq(6)
    end

    it "does not modify the passed array" do
      expect(more_cards).to eq(more_cards_dup)
    end
  end

  describe "#play_books" do
    let(:book_cards) do
      [
        Card.new(:clubs, :ten),
        Card.new(:diamonds, :eight),
        Card.new(:hearts, :three),
        Card.new(:spades, :three),
        Card.new(:spades, :nine),
        Card.new(:diamonds, :three),
        Card.new(:diamonds, :ten),
        Card.new(:clubs, :three)
      ]
    end

    let(:book_hand) do
      Hand.new(book_cards)
    end

    context "when the hand contains a book (four of a kind)" do
      before(:each) do
        book_hand.play_books
      end

      it "removes books from the hand" do
        expect(book_hand.count).to eq(4)
      end

      it "increments the books instance variable" do
        expect(book_hand.books).to eq(1)
      end
    end

    context "when the hand does not contain four of a kind" do
      before(:each) do
        hand.play_books
      end

      it "does not modify the hand" do
        expect(hand.count).to eq(3)
      end

      it "does not increment the books instance variable" do
        expect(hand.books).to eq(0)
      end
    end
  end
end
