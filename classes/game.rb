require_relative 'deck'

class Game

  attr_reader :player_array
  attr_accessor :top_card

  def initialize

    @player_array = Array.new
    @current_player = nil
    @numrounds = 3
    @suit = nil
    @top_card = nil
    @deck = Deck.new

  end

end
