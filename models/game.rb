require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :player_one, :player_two
  attr_reader :board
  def initialize(game_board)
    @board = game_board
    @player_one = "player one"
    @player_two = "player two"
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

  def game_play
    current_player = player_one.symbol == board.first_player ? player_one : player_two
    puts board
    until board.game_over || board.tie
      begin
        puts "#{current_player.name} make your move..."
        current_move = current_player.type == "human" ? current_player.get_move : current_player.get_move(board.get_best_move(current_player.symbol))
      end while board.non_valid_move(current_move)
      board.update(current_move.to_i, current_player.symbol)
      current_player = player_swap(current_player)
      puts board
    end
    game_results(current_player)
  end

  private

  def unique_player_symbols(player)
    player.symbol != player_swap(player).symbol
  end

  def game_results(current_player)
    board.game_over ? "The Winner is #{player_swap(current_player).name}." : "Tie Game."
  end

  def player_swap(current_player)
    player_one == current_player ? player_two : player_one
  end
end

