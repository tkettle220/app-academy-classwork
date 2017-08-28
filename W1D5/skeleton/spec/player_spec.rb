require "rspec"
require "card"
require "hand"
require "player"

describe Player do
  let(:deck) do
    double("deck", deal: [Card.new(:hearts, :king)])
  end

  let(:empty_hand) { Hand.new([]) }

  let(:hand) do
    Hand.new([
      Card.new(:diamonds, :king),
      Card.new(:diamonds, :queen),
      Card.new(:diamonds, :queen),
      Card.new(:diamonds, :queen),
      Card.new(:diamonds, :queen)
    ])
  end

  let(:others) do
    ["Ryan", "Eric"]
  end

  let(:player) do
    Player.new("Ned", hand)
  end

  describe "#initialize" do
    it "initializes with a name" do
      expect(player.name).to eq("Ned")
    end

    it "initializes with a hand" do
      expect(player.hand).to eq(hand)
    end
  end

  describe "#books" do
    it "delegates to Hand#books" do
      expect(hand).to receive(:books)

      player.books
    end
  end

  describe "#take" do
    let(:new_card) { double("card") }

    it "adds cards to the hand" do
      expect(player.hand).to receive(:receive)

      player.take([new_card])
    end

    it "plays any books made after adding the cards" do
      expect(player).to receive(:play_books)

      player.take([new_card])
    end
  end

  describe "#give_up" do
    it "delegates to Hand#give_up" do
      expect(player.hand).to receive(:give_up).with(:queen)

      player.give_up(:queen)
    end
  end

  describe "#has_value?" do
    context "when the player's hand contains the value" do
      it "returns true" do
        expect(player.has_value?(:king)).to be_truthy
      end
    end

    context "when the player's hand does not contain the value" do
      it "returns false" do
        expect(player.has_value?(:ace)).to be_falsey
      end
    end
  end

  describe "#go_fish" do
    let(:fished_card) { double("Card", suit: :hearts, value: :king) }
    it "draws a card from the deck" do
      expect(deck).to receive(:deal).with(1)

      player.go_fish(deck)
    end

    it "takes cards from the deck" do
      allow(deck).to receive(:deal).with(1).and_return(fished_card)

      expect(player).to receive(:take).with(fished_card)

      player.go_fish(deck)
    end

    it "plays any books made after drawing" do
      expect(player).to receive(:play_books)

      player.go_fish(deck)
    end
  end

  describe "#play_books" do
    it "delegates to the hand's #play_books method" do
      expect(player.hand).to receive(:play_books)

      player.play_books
    end
  end

  describe "#make_request" do
    it "prompts the player to choose a card value" do
      expect(player).to receive(:choose_value)

      player.make_request(others)
    end

    it "prompts the player to choose a target player" do
      expect(player).to receive(:choose_player).with(others)

      player.make_request(others)
    end

    it "returns an array of the value and target" do
      value = :king
      target = double("player")

      allow(player).to receive(:choose_value) { value }
      allow(player).to receive(:choose_player) { target }

      expect(player.make_request(others)).to eq([value, target])
    end
  end

  describe "#in_play?" do
    context "when the player's hand is empty" do
      it "returns false" do
        done_player = Player.new("Jeff", empty_hand)

        expect(done_player.in_play?).to be_falsey
      end
    end

    context "when the player's hand is not empty" do
      it "returns true" do
        expect(player.in_play?).to be_truthy
      end
    end
  end
end
