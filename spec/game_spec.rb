require_relative '../models/game'

describe Game do
  let(:new_game) {Game.new(Tic_Tac_Toe_Board.new)}
  let(:human_player) {Player.new(name: "George", type: "human", symbol: "X")}
  let(:computer_player_one) {Player.new(name: "IBM", type: "computer", symbol: "O")}
  let(:computer_player_two) {Player.new(name: "Gateway2000", type: "computer", symbol: "X")}

  before :each do
    new_game.player_one = computer_player_one
    new_game.player_two = computer_player_two
    allow($stdout).to receive(:puts)
    allow(new_game).to receive(:screen_reset)
  end

  describe "#new" do
    it "creates new Game object" do
      expect(new_game).to be_a Game
    end

    it "has a new board object" do
      expect(new_game.board).to be_a Tic_Tac_Toe_Board
    end
  end

  describe "#setup_player_one" do
    it "takes in 3 inputs and creates a player object" do
      allow_any_instance_of(Player).to receive(:gets).and_return("Jeff", "human", "X")
      new_game.setup_player_one
      expect(new_game.player_one).to be_a Player
      expect(new_game.player_one.name).to eq "Jeff"
      expect(new_game.player_one.type).to eq "human"
      expect(new_game.player_one.symbol).to eq "X"
    end

    it "will request another symbol if invalid symbol entered" do
      allow_any_instance_of(Player).to receive(:gets).and_return("Jeff", "human", "J", "O")
      new_game.setup_player_one
      expect(new_game.player_one.symbol).to eq "O"
    end
  end

  describe "#setup_player_two" do
    it "takes in 3 inputs and creates a player object" do
      allow_any_instance_of(Player).to receive(:gets).and_return("Jeff", "human", "X")
      new_game.setup_player_two
      expect(new_game.player_two).to be_a Player
      expect(new_game.player_two.name).to eq "Jeff"
      expect(new_game.player_two.type).to eq "human"
      expect(new_game.player_two.symbol).to eq "X"
    end

    it "will request another symbol if invalid symbol entered" do
      allow_any_instance_of(Player).to receive(:gets).and_return("Jeff", "human", "J", "X")
      new_game.setup_player_two
      expect(new_game.player_two.symbol).to eq "X"
    end

    it "will request another symbol if player_one already has that symbol" do
      allow_any_instance_of(Player).to receive(:gets).and_return("Jeff", "human", "O", "X")
      new_game.setup_player_two
      expect(new_game.player_two.symbol).to eq "X"
    end
  end

  describe "#get_move" do
    it "requests move input from human player" do
      new_game.player_two = human_player
      new_game.current_player = new_game.player_two
      allow(new_game.player_two).to receive(:gets).and_return("4")
      expect(new_game.get_move).to eq "4"
    end

    it "it calls Board's get_best_move if computer player" do
      new_game.current_player = new_game.player_two
      allow(new_game.board).to receive(:get_best_move).and_return("4")
      expect(new_game.get_move).to eq "4"
    end
  end
end
