require_relative '../new_game'

describe Game do
  before :each do
    @player1 = Player.new(player_name: "George", player_type: "human", player_symbol: "X")
    @player2 = Player.new(player_name: "Gateway2000", player_type: "computer", player_symbol: "O")
    @new_game = Game.new(@player1, @player2)
  end

  describe "game#new" do
    it "creates new Game object" do
      expect(@new_game).to be_a Game
    end

    it "has a new board object" do
      expect(@new_game.board).to be_a Board
    end

    it "has Player objects" do
      expect(@new_game.player_one).to be_a Player
      expect(@new_game.player_two).to be_a Player
    end
  end
end
