class Player
  attr_reader :player_name, :player_type, :player_symbol

  def initialize(args)
    @player_name = args[:player_name]
    @player_type = args[:player_type]
    @player_symbol = args[:player_symbol]
  end

  def get_player_move
    puts "Enter your move: "
    move = gets.chomp
    puts move
    return move
  end
end