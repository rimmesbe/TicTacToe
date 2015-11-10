require_relative '../new_game'

describe Game do
  before :each do
    @player1 = Player.new(name: "George", type: "human", symbol: "X")
    @player2 = Player.new(name: "Gateway2000", type: "computer", symbol: "O")
    @new_game = Game.new
  end

  describe "game#new" do
    it "creates new Game object" do
      expect(@new_game).to be_a Game
    end

    it "has a new board object" do
      expect(@new_game.board).to be_a Board
    end

    it "has Player objects" do
      expect(@new_game.player_one).to eq "player one"
      expect(@new_game.player_two).to eq "player two"
    end
  end
end
