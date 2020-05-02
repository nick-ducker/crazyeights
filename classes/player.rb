

class Player

  attr_reader :player_number, :name
  attr_accessor :hand, :score

  def initialize(name)

    #@player_number = player_number
    @name = name
    @hand = nil
    @score = 0

  end

  def card_select(input)
    return input if input == "PASS"
    if @hand.include?(input.upcase)
      return input.upcase
    else
      raise StandardError.new("That is an invalid selection")
    end
  end

end