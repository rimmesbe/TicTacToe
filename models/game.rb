require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board, :player_one, :player_two

  def initialize
    @board = Board.new(3, 3)
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

  def game_play
    current_player = @player_one.symbol == "X" ? @player_one : @player_two
    until game_over || tie
      begin
        puts "#{current_player.name} make your move..."
        current_move = current_player.type == "human" ? current_player.get_move : current_player.get_move(get_best_move(current_player))
      end while non_valid_move(current_move)
      @board.update(current_move.to_i, current_player.symbol)
      current_player = player_swap(current_player)
      puts @board
    end
    game_results(current_player)
  end

  def get_best_move(current_player)
    board = @board.current_board
    available_spaces = []
    opponent_symbol = player_swap(current_player).symbol

    board.each do |spot|
      unless non_valid_move(spot)
        available_spaces << spot
        return spot if one_move_away(current_player.symbol, spot)
      end
    end
    available_spaces.each {|available_spot| return available_spot if one_move_away(opponent_symbol, available_spot) }
    if available_spaces.include?("4")
      return "4"
    else
      # opposite corners counter move
      if (board[0] == opponent_symbol && board[8] == opponent_symbol) || (board[2] == opponent_symbol && board[6] == opponent_symbol)
        available_spaces.each {|available_spot| return available_spot if (available_spot.to_i % 2 == 1)}
      end
      available_spaces.each {|available_spot| return available_spot if (available_spot.to_i % 2 == 0)}
      return available_spaces[0]
    end
  end

  private

  def game_over
    b = @board.current_board
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie
    @board.current_board.all? { |s| s == @player_one.symbol || s == @player_two.symbol }
  end

  def player_swap(current_player)
    @player_one == current_player ? @player_two : @player_one
  end

  def symbol_checker(player)
    until ["X", "O"].include?(player.symbol)
      puts "Please pick 'X' or 'O' for symbol:"
      player.symbol = player.create_symbol
    end
  end

  def non_valid_move(move)
    move.match(/^[0-8]$/) ? ["X", "O"].include?(@board.current_board[move.to_i]) : true
  end

  def one_move_away(player_symbol, spot)
    @board.current_board[spot.to_i] = player_symbol
    if game_over
      @board.current_board[spot.to_i] = spot
      return true
    end
    @board.current_board[spot.to_i] = spot
    false
  end

  def game_results(current_player)
    tie ? (puts "Game ends in a tie... boring.") : (puts "#{player_swap(current_player).name} WINS!!!!!!")
  end
end

g = Game.new
g.start_game