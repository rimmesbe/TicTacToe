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

  describe "#get_best_move" do
    it "returns middle spot if not one_move_away" do
      expect(ttt_board.get_best_move("X")).to eq ("4")
    end

    it "returns winning spot if one_move_away" do
      2.times {|i| ttt_board.current_board[i] = "X"}
      expect(ttt_board.get_best_move("X")).to eq "2"
    end

    it "returns losing spot if one_move_away" do
      2.times {|i| ttt_board.current_board[i] = "O"}
      expect(ttt_board.get_best_move("X")).to eq "2"
    end

    it "returns a non-corner/non-middle spot if opponent has opposite corners" do
      [0,8].each {|n| ttt_board.current_board[n] = "O"}
      ttt_board.current_board[4] = "X"
      expect(ttt_board.get_best_move("X")).to eq "1"
    end

    it "returns corner spot over non-corner spot" do
      ttt_board.current_board[4] = "O"
      expect(ttt_board.get_best_move("X")).to eq "0"
    end
  end

  describe "#tie" do
    it "returns false when board not full" do
      expect(ttt_board.tie).to be false
    end

    it "returns true when board is full" do
      ttt_board.current_board.map! { |spot| "X"}
      expect(ttt_board.tie).to be true
    end
  end

  describe "#game_over" do
    it "returns false if they're are not 3 in row symbols" do
      expect(ttt_board.game_over).to be false
    end

    it "returns true if 3 symbols are in a row horizontal" do
      3.times {|i| ttt_board.current_board[i] = "X"}
      expect(ttt_board.game_over).to be true
    end

    it "returns true if 3 symbols are in a row verticle" do
      [0, 3, 6].each {|n| ttt_board.current_board[n] = "X"}
      expect(ttt_board.game_over).to be true
    end

    it "returns true if 3 symbols are in a row diagonally" do
      [0, 4, 8].each {|n| ttt_board.current_board[n] = "X"}
      expect(ttt_board.game_over).to be true
    end
  end

  describe "#symbol_check" do
    it "returns false if not X or O" do
      expect(ttt_board.symbol_check("C")).to be false
    end

    it "returns true if X or O" do
      expect(ttt_board.symbol_check("X")).to be true
      expect(ttt_board.symbol_check("O")).to be true
    end
  end

  describe "#non_valid_move" do
    it "returns true if non-numeric string 0-8 submitted" do
      expect(!!ttt_board.non_valid_move("f")).to be true
    end

    it "returns true if X or O already in that spot" do
      ttt_board.current_board[4] = "X"
      expect(ttt_board.non_valid_move("4")).to be true
    end

    it "returns false if valid spot submitted" do
      expect(ttt_board.non_valid_move("4")).to be false
    end
  end
end