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

  def start_game
    puts "#{board.title}"
    puts "Enter player one's information: "
    @player_one = Player.new
    until board.symbol_checker(player_one.symbol) do player_one.symbol = player_one.create_symbol end
    screen_reset
    puts "Enter player two's information: "
    @player_two = Player.new
    until unique_player_symbols(player_two) && board.symbol_checker(player_two.symbol)
      puts "#{player_one.name} picked #{player_one.symbol}."
      player_two.symbol = player_two.create_symbol
    end
    puts "#{player_two.name}'s symbol is #{player_two.symbol}"
    screen_reset
    puts "As you may have guessed... X goes first."
    game_play()
  end

  def game_play
    current_player = player_one.symbol == board.first_player ? player_one : player_two
    puts board
    until board.game_over || board.tie
      begin
        puts "#{current_player.name} make your move..."
        current_move = current_player.type == "human" ? current_player.get_move : current_player.get_move(board.get_best_move(current_player.symbol))
      end while board.non_valid_move(current_move)
      screen_reset
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

  def screen_reset
    sleep 1.5
    system "clear"
  end
end

# g = Game.new(Tic_Tac_Toe_Board.new)
# p g.start_game
