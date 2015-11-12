class Board
  attr_reader :current_board, :rows, :columns
  def initialize(rows = 0, columns = 0)
    @rows = rows
    @columns = columns
    @current_board = set_board_up
  end

  def update(index, value)
    current_board[index.to_i] = value
  end

  def to_s
    board_array = []
    current_board.each_slice(columns) {|x| board_array << x}
    board_array.map do |slot|
      slot.map{|spot| (spot_format(spot)).to_s}.join("|")
    end.join(join_structure)
  end

  private

  def join_structure
    return ("\n"+ columns.times.map {|i| "___"}.join("|")+"\n")
  end

  def spot_format(spot)
    spot.to_s.length == 1 ? " "+spot.to_s+" " : " "+spot.to_s
  end

  def set_board_up
    spot_array = []
    (rows * columns).times {|idx| spot_array << idx.to_s}
    spot_array
  end
end

class Tic_Tac_Toe_Board < Board
  attr_reader :current_board

  def initialize
    @columns = 3
    @rows = 3
    @current_board = set_board_up
  end

  private

  def non_valid_move(move)
    move.match(/^[0-8]$/) ? ["X", "O"].include?(current_board[move.to_i]) : true
  end

  def one_move_away(symbol, spot)
    current_board[spot.to_i] = symbol
    if game_over
      current_board[spot.to_i] = spot
      return true
    end
    current_board[spot.to_i] = spot
    false
  end

  def tie
    current_board.all? { |s| s == "X" || s == "O" }
  end

  def game_over
    [current_board[0], current_board[1], current_board[2]].uniq.length == 1 ||
    [current_board[3], current_board[4], current_board[5]].uniq.length == 1 ||
    [current_board[6], current_board[7], current_board[8]].uniq.length == 1 ||
    [current_board[0], current_board[3], current_board[6]].uniq.length == 1 ||
    [current_board[1], current_board[4], current_board[7]].uniq.length == 1 ||
    [current_board[2], current_board[5], current_board[8]].uniq.length == 1 ||
    [current_board[0], current_board[4], current_board[8]].uniq.length == 1 ||
    [current_board[2], current_board[4], current_board[6]].uniq.length == 1
  end
end

# t = Tic_Tac_Toe_Board.new
# puts t