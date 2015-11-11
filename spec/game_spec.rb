require_relative '../models/game'

describe Game do
  before :each do
    @human_player = Player.new(name: "George", type: "human", symbol: "X")
    @computer_player_one = Player.new(name: "IBM", type: "computer", symbol: "O")
    @computer_player_two = Player.new(name: "Gateway2000", type: "computer", symbol: "X")
    @new_game = Game.new
    @new_game.player_one = @computer_player_one
    @new_game.player_two = @computer_player_two
  end

  describe "game#new" do
    it "creates new Game object" do
      expect(@new_game).to be_a Game
    end

    it "has a new board object" do
      expect(@new_game.board).to be_a Board
    end

    it "has Player attributes" do
      expect(@new_game.player_one).to be_a Player
      expect(@new_game.player_two).to be_a Player
    end
  end

  describe "game#tie" do
    it "returns false when board not full" do
      expect(@new_game.tie).to be false
    end

    it "returns true when board is full" do
      @new_game.board.current_board.map! { |spot| "X"}
      expect(@new_game.tie).to be true
    end
  end

end
