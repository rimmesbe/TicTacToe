class Tic_Tac_Toe_Rules
  attr_reader :title, :first_player

  def initialize
    @title = "Welcome to... X shot first Tic Tac Toe!"
    @first_player = "X"
  end

  def symbol_check(symbol)
    if ["X", "O"].include?(symbol)
      return true
    else
      puts "Please pick 'X' or 'O' for symbol:"
      return false
    end
  end

  def tie(current_board)
    current_board.all? { |s| s == "X" || s == "O" }
  end

  def game_over(current_board)
    [current_board[0], current_board[1], current_board[2]].uniq.length == 1 ||
    [current_board[3], current_board[4], current_board[5]].uniq.length == 1 ||
    [current_board[6], current_board[7], current_board[8]].uniq.length == 1 ||
    [current_board[0], current_board[3], current_board[6]].uniq.length == 1 ||
    [current_board[1], current_board[4], current_board[7]].uniq.length == 1 ||
    [current_board[2], current_board[5], current_board[8]].uniq.length == 1 ||
    [current_board[0], current_board[4], current_board[8]].uniq.length == 1 ||
    [current_board[2], current_board[4], current_board[6]].uniq.length == 1
  end

  def non_valid_move(move, current_board)
    move.match(/^(?![0-8]$)/) || ["X", "O"].include?(current_board[move.to_i])
  end

end
