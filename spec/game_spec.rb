require_relative '../models/game'

describe Game do
  before :each do
    @computer_player_one = Player.new(name: "IBM", type: "computer", symbol: "O")
    @computer_player_two = Player.new(name: "Gateway2000", type: "computer", symbol: "X")
    @new_game = Game.new(Tic_Tac_Toe_Board.new)
    @new_game.player_one = @computer_player_one
    @new_game.player_two = @computer_player_two
    allow($stdout).to receive(:puts)
    allow(@new_game).to receive(:screen_reset)
  end

  describe "#new" do
    it "creates new Game object" do
      expect(@new_game).to be_a Game
    end

    it "has a new board object" do
      expect(@new_game.board).to be_a Tic_Tac_Toe_Board
    end
  end

  describe "#game_play" do
    it "should return winner when there is a winner" do
      @human_player = Player.new(name: "George", type: "human", symbol: "X")
      @new_game.player_two = @human_player
      [0,1].each {|s| @new_game.board.update(s, "X")}
      allow(@new_game.player_two).to receive(:gets).and_return("2")
      expect(@new_game.game_play).to eq "The Winner is... George."
    end

    it "should return winner as Tie with 2 computer players" do
      expect(@new_game.game_play).to eq "The Winner is... Tie Game."
    end
  end
end
