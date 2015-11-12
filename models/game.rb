require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :player_one, :player_two
  attr_reader :winner, :board
  def initialize(game_board)
    @board = game_board
    @player_one = "player one"
    @player_two = "player two"
    @winner = ""
  end

  def start_game
    puts "#{board.title}"
    puts "Enter player one's information: "
    @player_one = Player.new
    until board.symbol_checker(player_one.symbol) do player_one.symbol = player_one.create_symbol end
    screen_reset
    puts "Enter player two's information: "
    @player_two = Player.new
    until board.symbol_checker(player_two.symbol) do player_two.symbol = player_two.create_symbol end
      #TODO FIX THIS LOGIC
    unique_player_symbols(player_two)
    puts "#{player_two.name}'s symbol is #{player_two.symbol}"
    screen_reset
    puts "As you may have guessed... X goes first."
    puts board
    game_play()
  end

  def unique_player_symbols(player)
    until player.symbol != player_swap(player).symbol
      puts "#{player_swap(player).name} already picked that symbol."
      player.create_symbol
    end
  end

  def game_play
    current_player = player_one.symbol == board.first_player ? player_one : player_two
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
    "The Winner is... "+ game_results(current_player)+ "."
  end

  private

  def game_results(current_player)
    board.game_over ? winner = player_swap(current_player).name : winner = "Tie Game"
  end

  def player_swap(current_player)
    @player_one == current_player ? @player_two : @player_one
  end

  def screen_reset
    sleep 1.5
    system "clear"
  end
end

g = Game.new(Tic_Tac_Toe_Board.new)
p g.start_game
