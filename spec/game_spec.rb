require_relative '../models/game'

describe Game do
  before :each do
    @human_player = Player.new(name: "George", type: "human", symbol: "X")
    @computer_player_one = Player.new(name: "IBM", type: "computer", symbol: "O")
    @computer_player_two = Player.new(name: "Gateway2000", type: "computer", symbol: "X")
    @new_game = Game.new
    @new_game.player_one = @computer_player_one
    @new_game.player_two = @computer_player_two
    allow($stdout).to receive(:puts)
    allow(@new_game).to receive(:screen_reset)
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

  describe "game#game_play" do
    it "should return winner when there is a winner" do
      @new_game.player_two = @human_player
      [0,1].each {|s| @new_game.board.current_board[s] = "X"}
      allow(@new_game.player_two).to receive(:gets).and_return("2")
      expect(@new_game.game_play).to eq "The Winner is... George."
    end

    it "should return winner as Tie with 2 computer players" do
      expect(@new_game.game_play).to eq "The Winner is... Tie Game."
    end
  end

  describe "game#tie" do
    it "returns false when board not full" do
      expect(@new_game.send(:tie)).to be false
    end

    it "returns true when board is full" do
      @new_game.board.current_board.map! { |spot| "X"}
      expect(@new_game.send(:tie)).to be true
    end
  end

  describe "game#game_over" do
    it "returns false if they're are not 3 in row symbols" do
      expect(@new_game.send(:game_over)).to be false
    end

    it "returns true if 3 symbols are in a row horizontal" do
      3.times {|i| @new_game.board.current_board[i] = "X"}
      expect(@new_game.send(:game_over)).to be true
    end

    it "returns true if 3 symbols are in a row verticle" do
      [0, 3, 6].each {|n| @new_game.board.current_board[n] = "X"}
      expect(@new_game.send(:game_over)).to be true
    end

    it "returns true if 3 symbols are in a row diagonally" do
      [0, 4, 8].each {|n| @new_game.board.current_board[n] = "X"}
      expect(@new_game.send(:game_over)).to be true
    end
  end

end
