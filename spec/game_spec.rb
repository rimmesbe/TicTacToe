require_relative '../models/game'

describe Game do
  before :each do
    @human_player = Player.new(name: "George", type: "human", symbol: "X")
    @computer_player_one = Player.new(name: "IBM", type: "computer", symbol: "O")
    @computer_player_two = Player.new(name: "Gateway2000", type: "computer", symbol: "X")
    @new_game = Game.new
  end

  describe "game#new" do
    it "creates new Game object" do
      expect(@new_game).to be_a Game
    end

    it "has a new board object" do
      expect(@new_game.board).to be_a Board
    end

    it "has Player attributes" do
      expect(@new_game.player_one).to eq "player one"
      expect(@new_game.player_two).to eq "player two"
    end
  end
end
