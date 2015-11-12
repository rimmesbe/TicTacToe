require_relative '../models/player'

describe Player do

  before :each do
      @player_human = Player.new(name: "Jacob", type: "human", symbol: "X")
      @player_computer = Player.new(name: "comp1", type: "computer", symbol: "O")
      allow($stdout).to receive(:puts)
  end

  describe "Player#new" do
    it "takes 3 parameters and returns a Player object" do
      expect(@player_human).to be_a Player
    end
  end

  describe "#name" do
    it "returns the correct name" do
      expect(@player_human.name).to eq "Jacob"
    end
  end

  describe "#type" do
    it "returns the correct type" do
      expect(@player_human.type).to eq "human"
    end
  end

  describe "#symbol" do
    it "returns the correct symbol" do
      expect(@player_human.symbol).to eq "X"
    end
  end

  describe "#get_move" do
    it "returns the correct players move" do
      allow(@player_human).to receive(:gets).and_return("8\n")
      expect(@player_human.get_move).to eq "8"
    end

    it "returns suggested move if type != human" do
      expect(@player_computer.get_move("4")).to eq "4"
    end
  end

  describe "#create_name" do
    it "returns user input as new name of player" do
      allow(@player_human).to receive(:gets).and_return("Joe\n")
      expect(@player_human.create_name).to eq "Joe"
    end
  end

  describe "#create_symbol" do
    it "returns user input as new symbol of player" do
      allow(@player_human).to receive(:gets).and_return("O\n")
      expect(@player_human.create_symbol).to eq "O"
    end
  end

  describe "#choose_type" do
    it "returns user input as new type of player" do
      allow(@player_human).to receive(:gets).and_return("computer\n")
      expect(@player_human.choose_type).to eq "computer"
    end
  end

end