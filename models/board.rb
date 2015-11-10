class Board
  attr_reader :current_board
  def initialize
    @current_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def update(index, value)
    current_board[index.to_i] = value
  end

  def to_s
    board_array = []
    current_board.each_slice(3) {|x| board_array << x}
    board_array.map do |slot|
      slot.map(&:to_s).join(" | ")
    end.join("\n__|___|__\n")
  end
end
