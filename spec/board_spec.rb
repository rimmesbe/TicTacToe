require_relative '../models/board'

describe Board do

  let(:three_by_three) {Board.new(3, 3)}
  let(:four_by_four) {Board.new(4, 4)}

  describe "#new" do
    it "takes 2 parameters and returns a board object" do
      expect(three_by_three).to be_a Board
    end
  end

  describe "#current_board" do
    it "returns current board of three_by_three" do
      expect(three_by_three.current_board).to eq ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    end

    it "returns current board of four_by_four" do
      expect(four_by_four.current_board).to eq ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]
    end
  end

  describe "#update" do
    it "changes one spot on current board" do
      three_by_three.update("4", "X")
      expect(three_by_three.current_board).to eq ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    end
  end

  describe "#to_s" do
    it "prints out the current board" do
      expect(three_by_three.to_s).to eq " 0 | 1 | 2 \n___|___|___\n 3 | 4 | 5 \n___|___|___\n 6 | 7 | 8 "
    end
  end
end

describe Tic_Tac_Toe_Board do
  before :each do
    allow($stdout).to receive(:puts)
  end

  let(:ttt_board) {Tic_Tac_Toe_Board.new}

  describe "#new" do
    it "has 3 columns" do
      expect(ttt_board.columns).to eq 3
    end

    it "has 3 rows" do
      expect(ttt_board.rows).to eq 3
    end

    it "returns current_board" do
      expect(ttt_board.current_board).to eq ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    end
  end
end