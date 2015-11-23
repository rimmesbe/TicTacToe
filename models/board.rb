require_relative 'tic_tac_toe_rules'
require_relative 'tic_tac_toe_ai'

class Board
  attr_reader :current_board, :rows, :columns
  def initialize(rows = 0, columns = 0)
    @rows = rows
    @columns = columns
    @current_board = Array.new((rows * columns).times.map {|idx| idx.to_s})
  end

  def update(index, value)
    current_board[index.to_i] = value
  end

  def to_s
    board_array = []
    current_board.each_slice(columns) {|x| board_array << x}
    board_array.map do |slot|
      slot.map{|spot| (spot_format(spot)).to_s}.join("|")
    end.join("\n"+ columns.times.map {|i| "___"}.join("|")+"\n")
  end

  private

  def spot_format(spot)
    spot.to_s.length == 1 ? " "+spot.to_s+" " : " "+spot.to_s
  end
end

class Tic_Tac_Toe_Board < Board
  attr_reader :current_board, :ai, :rules

  def initialize
    @columns = 3
    @rows = 3
    @current_board = Array.new((rows * columns).times.map {|idx| idx.to_s})
    @ai = Tic_Tac_Toe_AI.new
    @rules = Tic_Tac_Toe_Rules.new
  end
end