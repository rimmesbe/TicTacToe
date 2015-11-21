require_relative 'game'
require_relative 'board'

class Game_Controller
  attr_reader :game

  def initialize(board)
    @game = Game.new(board)
  end

  def setup_game
    puts "#{game.board.title}"
    puts "Enter player one's information: "
    game.setup_player_one
    puts "Enter player two's information: "
    game.setup_player_two
    puts "As you may have guessed... X goes first."
    screen_reset
  end

  def play_game
    game.game_play
  end

  private

  def screen_reset
    sleep 1.5
    system "clear"
  end

end

if ARGV[0] == "run"
  ARGV.clear
  g = Game_Controller.new(Tic_Tac_Toe_Board.new)
  g.setup_game
  g.play_game
end