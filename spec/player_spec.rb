require_relative '../new_game'

describe Player do

  before :each do
      @player_human = Player.new(player_name: "Jacob", player_type: "human", player_symbol: "X");
      @player_computer = Player.new(player_name: "comp1", player_type: "computer", player_symbol: "O");
  end

  describe "#new" do
    it "takes 3 parameters and returns a Player object" do
      expect(@player_human).to be_a Player
    end
  end

  describe "#player_name" do
    it "returns the correct player_name" do
      expect(@player_human.player_name).to eq "Jacob"
    end
  end

  describe "#player_type" do
    it "returns the correct player_type" do
      expect(@player_human.player_type).to eq "human"
    end
  end

  describe "#player_symbol" do
    it "returns the correct player_symbol" do
      expect(@player_human.player_symbol).to eq "X"
    end
  end

  describe "#get_player_move" do
    it "returns the correct players move" do
      allow(@player_human).to receive(:gets).and_return("8\n")
      expect(@player_human.get_player_move).to eq "8"
    end

    it "returns suggested move if player_type != human" do
      expect(@player_computer.get_player_move("4")).to eq "4"
    end
  end

end