class Board
  attr_reader :current_board, :rows, :columns
  def initialize(rows, columns)
    @current_board = []
    (rows * columns).times {|idx| @current_board << idx.to_s}
    @rows = rows
    @columns = columns
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
end

