require_relative '../models/player'

describe Player do

  before :each do
    allow($stdout).to receive(:puts)
  end

  let(:player_human) {Player.new(name: "Jacob", type: "human", symbol: "X")}
  let(:player_computer) {Player.new(name: "comp1", type: "computer", symbol: "O")}

  describe "#new" do
    it "takes 3 parameters and returns a Player object" do
      expect(player_human).to be_a Player
    end

    it "calls create_name if no name supplied" do
      allow_any_instance_of(Player).to receive(:create_name).and_return("Adam")
      expect(Player.new(type: "human", symbol: "X").name).to eq "Adam"
    end

    it "calls create_symbol if no symbol supplied" do
      allow_any_instance_of(Player).to receive(:create_symbol).and_return("X")
      expect(Player.new(name: "Jackson", type: "human").symbol).to eq "X"
    end

    it "calls choose_type if no type supplied" do
      allow_any_instance_of(Player).to receive(:choose_type).and_return("human")
      expect(Player.new(name: "Jackson", symbol: "X").type).to eq "human"
    end
  end

  describe "#name" do
    it "returns the correct name" do
      expect(player_human.name).to eq "Jacob"
    end
  end

  describe "#type" do
    it "returns the correct type" do
      expect(player_human.type).to eq "human"
    end
  end

  describe "#symbol" do
    it "returns the correct symbol" do
      expect(player_human.symbol).to eq "X"
    end
  end

  describe "#get_move" do
    it "retrieves player input for move if type == human" do
      allow(player_human).to receive(:gets).and_return("8\n")
      expect(player_human.get_move).to eq "8"
    end

    it "returns suggested move if type != human" do
      expect(player_computer.get_move("4")).to eq "4"
    end

    it "returns default suggested move if none given for type != human" do
      expect(player_computer.get_move).to eq "_"
    end
  end

  describe "#create_name" do
    it "returns user input as new name of player" do
      allow(player_human).to receive(:gets).and_return("Joe\n")
      expect(player_human.create_name).to eq "Joe"
    end
  end

  describe "#create_symbol" do
    it "returns user input as new symbol of player" do
      allow(player_human).to receive(:gets).and_return("O\n")
      expect(player_human.create_symbol).to eq "O"
    end
  end

  describe "#choose_type" do
    it "returns user input as new type of player" do
      allow(player_human).to receive(:gets).and_return("computer\n")
      expect(player_human.choose_type).to eq "computer"
    end
  end

end