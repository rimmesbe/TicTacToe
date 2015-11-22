require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :player_one, :player_two, :current_player
  attr_reader :board, :current_move

  def initialize(game_board)
    @board = game_board
    @player_one = "player one"
    @player_two = "player two"
    @current_player = @player_one
    @current_move = ""
  end

  def setup_player_one
    @player_one = Player.new
    until board.symbol_check(player_one.symbol) do player_one.symbol = player_one.create_symbol end
  end

  def setup_player_two
    @player_two = Player.new
    until unique_player_symbols(player_two) && board.symbol_check(player_two.symbol)
      puts "#{player_one.name} picked #{player_one.symbol}."
      player_two.symbol = player_two.create_symbol
    end
  end

  def get_move
    @current_move = current_player.type == "human" ? current_player.get_move : current_player.get_move(board.get_best_move(current_player.symbol))
  end

  def update_board
    board.update(current_move.to_i, current_player.symbol)
  end

  def end_game
    board.game_over || board.tie
  end

  def set_current_player
    @current_player = player_one.symbol == board.first_player ? player_one : player_two
  end

  def change_current_player
    @current_player = player_swap(@current_player)
  end

  def non_valid_move(move)
    board.non_valid_move(move)
  end

  def game_results
    board.game_over ? "The Winner is #{player_swap(current_player).name}." : "Tie Game."
  end

  private

  def unique_player_symbols(player)
    player.symbol != player_swap(player).symbol
  end

  def player_swap(player)
    player_one == player ? player_two : player_one
  end
end

