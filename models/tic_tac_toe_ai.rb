class Tic_Tac_Toe_AI
  attr_reader :symbol, :opponent_symbol, :current_board

  def initialize
    @symbol = nil
    @opponent_symbol = nil
    @current_board = nil
  end

  def get_best_move(symbol_input, board)
    @current_board = board
    @symbol = symbol_input
    @opponent_symbol = symbol == "X" ? "O" : "X"
    available_spaces = find_available_spaces
    return critical_move(available_spaces) if critical_move(available_spaces)
    return "4" if available_spaces.include?("4")
    return counter_move(available_spaces) if counter_move(available_spaces)
    return default_move(available_spaces)
  end

  private

  def find_available_spaces
    available_spaces = []
    current_board.each {|spot| available_spaces << spot unless spot == "X" || spot == "O"}
    available_spaces
  end

  def critical_move(available_spaces)
    available_spaces.each {|available_spot| return available_spot if one_move_away(available_spot, symbol) }
    available_spaces.each {|available_spot| return available_spot if one_move_away(available_spot, opponent_symbol) }
    nil
  end

  def counter_move(available_spaces)
    if counter_opposite_corners
      available_spaces.each {|available_spot| return available_spot if (available_spot.to_i % 2 == 1)}
    end
    counter_corner = pick_opposite_corner
    return counter_corner if counter_corner
    side_splitter = split_sides
    return side_splitter if side_splitter
  end

  def one_move_away(spot, current_symbol)
    current_board[spot.to_i] = current_symbol
    if game_over
      current_board[spot.to_i] = spot
      return true
    end
    current_board[spot.to_i] = spot
    false
  end

  def counter_opposite_corners
    (current_board[0] == opponent_symbol && current_board[8] == opponent_symbol) || (current_board[2] == opponent_symbol && current_board[6] == opponent_symbol)
  end

  def split_sides
    if current_board[1] == opponent_symbol && current_board[3] == opponent_symbol && current_board[0].match(/^([0-8]$)/)
      return "0"
    elsif current_board[1] == opponent_symbol && current_board[5] == opponent_symbol && current_board[2].match(/^([0-8]$)/)
      return "2"
    elsif current_board[3] == opponent_symbol && current_board[7] == opponent_symbol && current_board[6].match(/^([0-8]$)/)
      return "6"
    elsif current_board[5] == opponent_symbol && current_board[7] == opponent_symbol && current_board[8].match(/^([0-8]$)/)
      return "8"
    end
  end

  def pick_opposite_corner
    if current_board[0] == opponent_symbol && current_board[8].match(/^([0-8]$)/)
      return "8"
    elsif current_board[2] == opponent_symbol && current_board[6].match(/^([0-8]$)/)
      return "6"
    elsif current_board[6] == opponent_symbol && current_board[2].match(/^([0-8]$)/)
      return "2"
    elsif current_board[8] == opponent_symbol && current_board[0].match(/^([0-8]$)/)
      return "0"
    end
  end

  def default_move(available_spaces)
    available_spaces.each {|available_spot| return available_spot if (available_spot.to_i % 2 == 0)}
    available_spaces[0]
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