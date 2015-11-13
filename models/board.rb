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
    available_spaces = []
    opponent_symbol = symbol == "X" ? "O" : "X"
    current_board.each do |spot|
      unless non_valid_move(spot)
        available_spaces << spot
        return spot if one_move_away(symbol, spot)
      end
    end
    available_spaces.each {|available_spot| return available_spot if one_move_away(opponent_symbol, available_spot) }
    if available_spaces.include?("4")
      return "4"
    else
      # opposite corners counter move
      if (current_board[0] == opponent_symbol && current_board[8] == opponent_symbol) || (current_board[2] == opponent_symbol && current_board[6] == opponent_symbol)
        available_spaces.each {|available_spot| return available_spot if (available_spot.to_i % 2 == 1)}
      end
      available_spaces.each {|available_spot| return available_spot if (available_spot.to_i % 2 == 0)}
      return available_spaces[0]
    end
  end

  def symbol_checker(symbol)
    if ["X", "O"].include?(symbol)
      return true
    else
      puts "Please pick 'X' or 'O' for symbol:"
      return false
    end
  end

  def non_valid_move(move)
    move.match(/^[0-8]$/) ? ["X", "O"].include?(current_board[move.to_i]) : true
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
end