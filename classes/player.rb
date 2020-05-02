

class Player

  attr_reader :player_number, :name
  attr_accessor :hand, :score

  def initialize(player_number, name)

    @player_number = player_number
    @name = name
    @hand = Array.new
    @score = 0

  end

end