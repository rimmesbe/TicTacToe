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
    puts "Welcome to... X shot first Tic Tac Toe!"
    puts "Enter player one's information: "
    player_one = Player.new
    board.symbol_checker(player_one.symbol)
    screen_reset
    puts "Enter player two's information: "
    player_two = Player.new
    board.symbol_checker(player_two.symbol)
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
    current_player = player_one.symbol == "X" ? player_one : player_two
    until game_over || tie
      begin
        puts "#{current_player.name} make your move..."
        current_move = current_player.type == "human" ? current_player.get_move : current_player.get_move(get_best_move(current_player))
      end while non_valid_move(current_move)
      screen_reset
      board.update(current_move.to_i, current_player.symbol)
      current_player = player_swap(current_player)
      puts board
    end
    "The Winner is... "+ game_results(current_player)+ "."
  end

  def get_best_move(current_player)
    b = board.current_board
    available_spaces = []
    opponent_symbol = player_swap(current_player).symbol

    b.each do |spot|
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
      if (b[0] == opponent_symbol && b[8] == opponent_symbol) || (b[2] == opponent_symbol && b[6] == opponent_symbol)
        available_spaces.each {|available_spot| return available_spot if (available_spot.to_i % 2 == 1)}
      end
      available_spaces.each {|available_spot| return available_spot if (available_spot.to_i % 2 == 0)}
      return available_spaces[0]
    end
  end

  private

  def game_results(current_player)
    game_over ? winner = player_swap(current_player).name : winner = "Tie Game"
  end

  # def game_over
  #   b = board.current_board
  #   [b[0], b[1], b[2]].uniq.length == 1 ||
  #   [b[3], b[4], b[5]].uniq.length == 1 ||
  #   [b[6], b[7], b[8]].uniq.length == 1 ||
  #   [b[0], b[3], b[6]].uniq.length == 1 ||
  #   [b[1], b[4], b[7]].uniq.length == 1 ||
  #   [b[2], b[5], b[8]].uniq.length == 1 ||
  #   [b[0], b[4], b[8]].uniq.length == 1 ||
  #   [b[2], b[4], b[6]].uniq.length == 1
  # end

  # def tie
  #   board.current_board.all? { |s| s == player_one.symbol || s == player_two.symbol }
  # end

  def player_swap(current_player)
    player_one == current_player ? player_two : player_one
  end

  def symbol_checker(player)
    until ["X", "O"].include?(player.symbol)
      puts "Please pick 'X' or 'O' for symbol:"
      player.symbol = player.create_symbol
    end
  end

  # def non_valid_move(move)
  #   move.match(/^[0-8]$/) ? ["X", "O"].include?(board.current_board[move.to_i]) : true
  # end

  # def one_move_away(player_symbol, spot)
  #   board.current_board[spot.to_i] = player_symbol
  #   if game_over
  #     board.current_board[spot.to_i] = spot
  #     return true
  #   end
  #   board.current_board[spot.to_i] = spot
  #   false
  # end

  def screen_reset
    sleep 1.5
    system "clear"
  end
end

# g = Game.new
# p g.start_game
