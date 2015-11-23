require_relative 'game'

class Game_Controller
  attr_reader :game

  def initialize(args = {})
    @game = Game.new(args[:board], args[:rules], args[:ai])
  end

  def setup_game
    puts "#{game.game_rules.title}"
    puts "Enter player one's information: "
    game.setup_player_one
    screen_reset
    puts "Enter player two's information: "
    game.setup_player_two
    puts "As you may have guessed... X goes first."
    game.set_current_player
    screen_reset
  end

  def play_game
    puts game.board
    until game.end_game
      begin
        puts "#{game.current_player.name} make your move..."
        game.get_move
      end while game.non_valid_move(game.current_move)
      next_turn
    end
    game.game_results
  end

  private

  def next_turn
    screen_reset
    game.update_board
    game.change_current_player
    puts game.board
  end

  def screen_reset
    sleep 1.5
    system "clear"
  end

end

if ARGV[0] == "run"
  ARGV.clear
  g = Game_Controller.new(board: Tic_Tac_Toe_Board.new, rules: Tic_Tac_Toe_Rules.new, ai: Tic_Tac_Toe_AI.new)
  g.setup_game
  puts g.play_game
end