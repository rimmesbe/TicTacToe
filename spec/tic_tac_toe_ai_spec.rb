require_relative '../models/tic_tac_toe_ai'

describe Tic_Tac_Toe_AI do
  let(:ai) {Tic_Tac_Toe_AI.new}
  let(:board) {["0","1","2","3","4","5","6","7","8"]}

  describe "#get_best_move" do
    it "returns middle spot if not one_move_away" do
      expect(ai.get_best_move("X", board)).to eq ("4")
    end

    it "returns winning spot if one_move_away" do
      2.times {|i| board[i] = "X"}
      expect(ai.get_best_move("X", board)).to eq "2"
    end

    it "returns losing spot if one_move_away" do
      2.times {|i| board[i] = "O"}
      expect(ai.get_best_move("X", board)).to eq "2"
    end

    it "returns a non-corner/non-middle spot if opponent has opposite corners" do
      [0,8].each {|n| board[n] = "O"}
      board[4] = "X"
      expect(ai.get_best_move("X", board)).to eq "1"
    end

    it "returns corner spot over non-corner spot" do
      board[4] = "O"
      expect(ai.get_best_move("X", board)).to eq "0"
    end
  end
end