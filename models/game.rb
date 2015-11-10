require_relative 'board'
require_relative 'player'

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
    @player_one = Player.new
    symbol_checker(@player_one)
    puts "Enter player two's information: "
    @player_one.symbol == "X" ? @player_two = Player.new(symbol: "O") : @player_two = Player.new(symbol: "X")
    puts "As you may have guessed... X goes first."
    puts @board
    game_play()
  end

  def symbol_checker(player)
    p player.symbol
    until ["x", "o", "X", "O"].include?(player.symbol)
      puts "Please pick 'X' or 'O' for symbol:"
      player.create_symbol
    end
  end

  def game_play
    current_player = @player_one.symbol == "X" ? @player_one : @player_two
    until game_over(@board.current_board) || tie(@board.current_board)
      puts "#{current_player.name} make your move..."
      current_move = current_player.type == "human" ? current_player.get_move : current_player.get_move(get_best_move(@board.current_board, current_player))
      @board.update(current_move, current_player.symbol)
      current_player = player_swap(current_player)
      puts @board
    end
    game_results(current_player)
  end

  def get_best_move(board, current_player)
    available_spaces = []
    opponent_symbol = player_swap(current_player).symbol
    best_move = nil

    board.each do |s|
      if s != @player_one.symbol && s != @player_two.symbol
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = current_player.symbol
      if game_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = opponent_symbol
        if game_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    elsif available_spaces.include?("4")
      return 4
    else
      if (board[0] == opponent_symbol && board[8] == opponent_symbol) || (board[2] == opponent_symbol && board[6] == opponent_symbol)
        available_spaces.each {|as| return as.to_i if (as.to_i % 2 == 1)}
      end
      available_spaces.each {|as| return as.to_i if (as.to_i % 2 == 0)}
      n = rand(0..(available_spaces.count-1))
      return available_spaces[n].to_i
    end
  end

  def game_over(b)
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == @player_one.symbol || s == @player_two.symbol }
  end

  private

  def player_swap(current_player)
    @player_one == current_player ? @player_two : @player_one
  end

  def game_results(current_player)
    if tie(@board.current_board)
      puts "Game ends in a tie... boring."
    else
      puts "#{player_swap(current_player).name} WINS!!!!!!"
    end
  end
end

g = Game.new
g.start_game