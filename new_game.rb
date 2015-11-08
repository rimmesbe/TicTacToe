class Player
  attr_reader :player_name, :player_type, :player_symbol

  def initialize(args)
    @player_name = args[:player_name]
    @player_type = args[:player_type]
    @player_symbol = args[:player_symbol]
  end

  def get_player_move(suggested_move = "_")
    if player_type == "human"
      puts "Enter your move: "
      move = gets.chomp
      puts move
      return move
    else
      puts "Suggesting move #{suggested_move}"
      return suggested_move
    end
  end
end

class Board
  attr_reader :current_board
  def initialize
    @current_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def update_board(index, value)
    @current_board[index.to_i] = value
  end
end

