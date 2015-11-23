require_relative '../models/tic_tac_toe_rules'

describe Tic_Tac_Toe_Rules do
  let(:rules) {Tic_Tac_Toe_Rules.new}
  let(:board) {["0","1","2","3","4","5","6","7","8"]}

  before :each do
    allow($stdout).to receive(:puts)
  end

  describe "#new" do
    it "has a title" do
      expect(rules.title).to eq "Welcome to... X shot first Tic Tac Toe!"
    end

    it "has a first player setting" do
      expect(rules.first_player).to eq "X"
    end
  end

  describe "#tie" do
    it "returns false when board not full" do
      expect(rules.tie(board)).to be false
    end

    it "returns true when board is full" do
      board.map! { |spot| "X"}
      expect(rules.tie(board)).to be true
    end
  end

  describe "#game_over" do
    it "returns false if they're are not 3 in row symbols" do
      expect(rules.game_over(board)).to be false
    end

    it "returns true if 3 symbols are in a row horizontal" do
      3.times {|i| board[i] = "X"}
      expect(rules.game_over(board)).to be true
    end

    it "returns true if 3 symbols are in a row verticle" do
      [0, 3, 6].each {|n| board[n] = "X"}
      expect(rules.game_over(board)).to be true
    end

    it "returns true if 3 symbols are in a row diagonally" do
      [0, 4, 8].each {|n| board[n] = "X"}
      expect(rules.game_over(board)).to be true
    end
  end

  describe "#symbol_check" do
    it "returns false if not X or O" do
      expect(rules.symbol_check("C")).to be false
    end

    it "returns true if X or O" do
      expect(rules.symbol_check("X")).to be true
      expect(rules.symbol_check("O")).to be true
    end
  end

  describe "#non_valid_move" do
    it "returns true if non-numeric string 0-8 submitted" do
      expect(!!rules.non_valid_move("f", board)).to be true
    end

    it "returns true if X or O already in that spot" do
      board[4] = "X"
      expect(rules.non_valid_move("4", board)).to be true
    end

    it "returns false if valid spot submitted" do
      expect(rules.non_valid_move("4", board)).to be false
    end
  end
end
