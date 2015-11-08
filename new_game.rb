class Player
  attr_reader :player_name, :player_type, :player_symbol

  def initialize(args)
    @player_name = args[:player_name]
    @player_type = args[:player_type]
    @player_symbol = args[:player_symbol]
  end
end