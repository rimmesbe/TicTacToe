class Player
  attr_reader :name, :type
  attr_accessor :symbol

  def initialize(args = {})
    @name = args[:name] || create_name
    @type = args[:type] || choose_type
    @symbol = args[:symbol] || create_symbol
  end

  def get_move(suggested_move = "_")
    if type == "human"
      puts "Enter your move: "
      move = gets.chomp
      return move
    else
      puts "Suggesting move #{suggested_move}"
      return suggested_move
    end
  end

  def create_name
    name = ""
    until name.length > 0
      puts "Enter player name: "
      name = gets.chomp
    end
    name
  end

  def create_symbol
    symbol = ""
    until symbol.length == 1
      puts "Enter single-digit symbol: "
      symbol = gets.chomp.upcase
    end
    symbol
  end

  def choose_type
    type = ""
    until type == "human" || type == "computer"
      puts "Player is human or computer?"
      type = gets.chomp
    end
    type
  end
end