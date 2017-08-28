require "rspec"
require "card"
require "deck"
require "game"
require "hand"
require "player"

describe Game do
  let(:players) do
    %w(Ned Ryan Judy Eric Velina).map { |name| Player.new(name) }
  end

  let(:deck) { Deck.new }
  let(:empty_deck) { Deck.new([]) }

  let(:game) { Game.new(players) }

  describe "#initialize" do
    context "when no deck is passed in" do
      it "initializes with an instance of Deck" do
        expect(game.deck).to be_a(Deck)
      end
    end

    context "when a deck is passed in" do
      let(:game) { Game.new(players, [], false) }

      it "initialized with the passed-in deck" do
        expect(game.deck).to eq([])
      end
    end
  end

  describe "#next_player!" do
    it "rotates the players array" do
      names = game.players.map(&:name)

      game.next_player!

      new_names = game.players.map(&:name)
      expect(new_names).to eq(names.rotate)
    end
  end

  describe "#current_player" do
    it "returns the first player of the players array" do
      expect(game.current_player).to be(players.first)
    end
  end

  describe "#other_players" do
    it "returns all players except the current player" do
      difference = game.players - game.other_players

      expect(difference).to eq([game.current_player])
    end
  end

  describe "#play_turn" do
    let(:ace) { Card.new(:hearts, :ace) }
    let(:empty_hand) { Hand.new([]) }
    let(:ace_hand) { Hand.new([ace]) }
    let(:ned) { Player.new("Ned", ace_hand) }
    let(:ryan) { Player.new("Ryan", empty_hand) }
    let(:game) { Game.new([ryan, ned], deck, false) }

    before(:each) do
      allow(ryan).to receive(:make_request) { [:ace, ned] }
    end

    it "calls the current player's #make_request method" do
      expect(ryan).to receive(:make_request)

      game.play_turn
    end

    it "checks if the target player has the requested cards" do
      expect(ned).to receive(:has_value?).with(:ace)

      game.play_turn
    end

    context "when the target player has the requested cards" do
      before(:each) do
        allow(ned).to receive(:has_value?).with(:ace) { true }
      end

      it "gives the cards to the current player" do
        expect(ned).to receive(:give_up).with(:ace).and_call_original
        expect(ryan).to receive(:take).with([ace])

        game.play_turn
      end

      it "does not pass the turn" do
        expect(game).not_to receive(:next_player!)

        game.play_turn
      end
    end

    context "when the target player does not have the requested cards" do
      before(:each) do
        allow(ned).to receive(:has_value?).with(:ace) { false }
      end

      it "tells the current_player to fish from the deck" do
        expect(ryan).to receive(:go_fish).with(game.deck)

        game.play_turn
      end

      it "passes the turn to the next player" do
        expect(game).to receive(:next_player!).exactly(1).times

        game.play_turn
      end
    end
  end

  describe "#game_over?" do
      let(:done_player1) { double("Player", :hand => [], :in_play? => false) }
      let(:done_player2) { double("Player", :hand => [], :in_play? => false) }

    context "when no cards are left in play" do
      let(:done_game) do
        Game.new([done_player1, done_player2], empty_deck, false)
      end

      it "returns true" do
        expect(done_game.game_over?).to be_truthy
      end
    end

    context "when there are cards left in the deck" do
      let(:game) { Game.new([done_player1, done_player2], deck, false) }
      it "returns false" do
        expect(game.game_over?).to be_falsey
      end
    end

    context "when there are players in play" do
        let(:player1) { double("Player", :hand => [1, 2, 3], :in_play? => true) }
        let(:player2) { double("Player", :hand => [4, 5, 6], :in_play? => true) }
      let(:game) { Game.new([player1, player2], empty_deck, false) }
      it "returns false" do
        expect(game.game_over?).to be_falsey
      end
    end
  end

  describe "#winner" do
    let(:winner) { double("Player", books: 6) }
    let(:loser) { double("Player", books: 1) }
    let(:game) { Game.new([loser, winner], deck, false) }

    it "returns the player with the most books" do
      expect(game.winner).to be(winner)
    end
  end
end
