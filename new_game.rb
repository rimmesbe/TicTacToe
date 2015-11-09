class Game
  attr_reader :board, :player_one, :player_two

  def initialize
    @board = Board.new
    @player_one = "player one"
    @player_two = "player two"
  end

  def start_game
    puts "Welcome to... X shot first Tic Tac Toe!"
    puts "Enter player one's information: "
    player_one = Player.new
    puts "Enter player two's information: "
    player_two = Player.new
  end

end

class Player
  attr_reader :player_name, :player_type, :player_symbol

  def initialize(args = {})
    @player_name = args[:player_name] || create_name
    @player_type = args[:player_type] || create_symbol
    @player_symbol = args[:player_symbol] || choose_type
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

  private

  def create_name
    puts "Enter player name: "
    name = STDIN.gets.chomp
  end

  def create_symbol
    puts "Enter player symbol: "
    symbol = gets.chomp
  end

  def choose_type
    puts "Player is human or computer?"
    type = gets.chomp
  end
end

class Board
  attr_reader :current_board
  def initialize
    @current_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def update_board(index, value)
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

