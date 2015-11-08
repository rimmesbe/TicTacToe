require_relative '../new_game'

describe Board do
  before :each do
    @new_board = Board.new
  end

  describe "Board#new" do
    it "it returns a board object" do
      expect(@new_board).to be_a Board
    end
  end

  describe "current_board" do
    it "returns current board" do
      expect(@new_board.current_board).to eq ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    end
  end

  describe "update_board" do
    it "changes one spot on current board" do
      @new_board.update_board("4", "X")
      expect(@new_board.current_board).to eq ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    end
  end
end