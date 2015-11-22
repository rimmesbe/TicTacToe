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
  attr_reader :current_board, :title, :first_player

  def initialize
    @title = "Welcome to... X shot first Tic Tac Toe!"
    @first_player = "X"
    @columns = 3
    @rows = 3
    @current_board = Array.new((rows * columns).times.map {|idx| idx.to_s})
  end

  def get_best_move(symbol)
    available_spaces = find_available_spaces
    opponent_symbol = symbol == "X" ? "O" : "X"
    return critical_move(symbol, available_spaces) if critical_move(symbol, available_spaces)
    return "4" if available_spaces.include?("4")
    return counter_move(opponent_symbol, available_spaces) if counter_move(opponent_symbol, available_spaces)
    return default_move(available_spaces)
  end

  def symbol_check(symbol)
    if ["X", "O"].include?(symbol)
      return true
    else
      puts "Please pick 'X' or 'O' for symbol:"
      return false
    end
  end

  def non_valid_move(move)
    move.match(/^(?![0-8]$)/) || ["X", "O"].include?(current_board[move.to_i])
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

  private

  def one_move_away(symbol, spot)
    current_board[spot.to_i] = symbol
    if game_over
      current_board[spot.to_i] = spot
      return true
    end
    current_board[spot.to_i] = spot
    false
  end

  def counter_opposite_corners(symbol)
    (current_board[0] == symbol && current_board[8] == symbol) || (current_board[2] == symbol && current_board[6] == symbol)
  end

  def split_sides(symbol)
    if current_board[1] == symbol && current_board[3] == symbol && current_board[0].match(/^([0-8]$)/)
      return "0"
    elsif current_board[1] == symbol && current_board[5] == symbol && current_board[2].match(/^([0-8]$)/)
      return "2"
    elsif current_board[3] == symbol && current_board[7] == symbol && current_board[6].match(/^([0-8]$)/)
      return "6"
    elsif current_board[5] == symbol && current_board[7] == symbol && current_board[8].match(/^([0-8]$)/)
      return "8"
    end
  end

  def pick_opposite_corner(symbol)
    if current_board[0] == symbol && current_board[8].match(/^([0-8]$)/)
      return "8"
    elsif current_board[2] == symbol && current_board[6].match(/^([0-8]$)/)
      return "6"
    elsif current_board[6] == symbol && current_board[2].match(/^([0-8]$)/)
      return "2"
    elsif current_board[8] == symbol && current_board[0].match(/^([0-8]$)/)
      return "0"
    end
  end

  def find_available_spaces
    available_spaces = []
    current_board.each {|spot| available_spaces << spot unless non_valid_move(spot)}
    available_spaces
  end

  def counter_move(opponent_symbol, available_spaces)
    if counter_opposite_corners(opponent_symbol)
      available_spaces.each {|available_spot| return available_spot if (available_spot.to_i % 2 == 1)}
    end
    counter_corner = pick_opposite_corner(opponent_symbol)
    return counter_corner if counter_corner
    side_splitter = split_sides(opponent_symbol)
    return side_splitter if side_splitter
  end

  def critical_move(symbol, available_spaces)
    opponent_symbol = symbol == "X" ? "O" : "X"
    available_spaces.each {|available_spot| return available_spot if one_move_away(symbol, available_spot) }
    available_spaces.each {|available_spot| return available_spot if one_move_away(opponent_symbol, available_spot) }
    nil
  end

  def default_move(available_spaces)
    available_spaces.each {|available_spot| return available_spot if (available_spot.to_i % 2 == 0)}
    available_spaces[0]
  end
end