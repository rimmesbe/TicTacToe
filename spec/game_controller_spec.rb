require_relative '../models/game_controller'

describe Game_Controller do
  let(:new_game_controller) {Game_Controller.new(Tic_Tac_Toe_Board.new)}
  let(:human_player) {Player.new(name: "George", type: "human", symbol: "X")}
  let(:computer_player_one) {Player.new(name: "IBM", type: "computer", symbol: "O")}
  let(:computer_player_two) {Player.new(name: "Gateway2000", type: "computer", symbol: "X")}

  before :each do
    allow(new_game_controller.game).to receive(:setup_player_one).and_return(new_game_controller.game.player_one = computer_player_one)
    allow(new_game_controller.game).to receive(:setup_player_two).and_return(new_game_controller.game.player_two = computer_player_two)
    allow($stdout).to receive(:puts)
    allow(new_game_controller).to receive(:screen_reset)
  end

  describe "#new" do
    it "creates new Game_Controller object" do
      expect(new_game_controller).to be_a Game_Controller
    end

    it "has a new Game object" do
      expect(new_game_controller.game).to be_a Game
    end
  end

  describe "#setup_game" do
    it "creates player_one and player_two for the Game object" do
      new_game_controller.setup_game
      expect(new_game_controller.game.player_one).to be computer_player_one
      expect(new_game_controller.game.player_two).to be computer_player_two
    end

    it "sets current player based on symbol X" do
      new_game_controller.setup_game
      expect(new_game_controller.game.current_player).to be computer_player_two
    end
  end

  describe "#play_game" do
    it "should return the results of the game" do
      new_game_controller.setup_game
      expect(new_game_controller.play_game).to eq "Tie Game."
    end

    100.times do
      it "computer player is unbeatable" do
        new_game_controller.game.player_one = computer_player_one
        new_game_controller.game.player_two = human_player
        new_game_controller.game.current_player = human_player
        allow(new_game_controller.game.player_two).to receive(:gets) {rand(0..8).to_s}
        results = new_game_controller.play_game
        expect(["Tie Game.", "The Winner is IBM."]).to include(results)
      end
    end
  end

end