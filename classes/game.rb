require_relative 'deck'
require_relative 'player'
require_relative '../module/scorehash'

class Game

  attr_reader :player_array
  attr_accessor :top_card, :deck, :current_player, :suit

  include ScoreHash

  def initialize

    @player_array = Array.new
    @current_player = nil
    @numrounds = 3
    @suit = nil
    @top_card = nil
    @deck = Deck.new

  end

  def add_player(playername)
    @player_array << Player.new(playername)
  end

  def deck_reader(int)
    cards = Array.new
    deck = @deck.deck.dup
    int.times do
      randcard = deck.sample
      cards << randcard
      deck.delete(randcard)
    end
    return cards
  end

  def deleter(inputarr, arr)
    inputarr.each {|x| arr.delete(x)} 
  end

  def validator(input, top_card, bool=false)
    return input.include?("8") ? false : true if bool
    return true if input == "PASS"
    return true if input[0] == top_card[0] || input[1] == top_card[1]
    return false
  end

  def player_select
    if @current_player == nil || @current_player == (@player_array.length - 1)
      @current_player = 0
    else
      @current_player += 1  
    end  
  end

  def suit_select(input)
    suits = ["hearts", "diamonds", "spades", "clubs"]       
    if suits.include?(input.downcase)
      return input.downcase.capitalize
    else
      raise StandardError.new("That is an invalid selection")
    end
  end

  def check_for_win
    @player_array[@current_player].hand.empty? ? false : true
  end

  def victory_score
    tally = 0
    @player_array.each do |x|
      x.hand.each {|y| tally += SCOREHASH[y[1]]}      
    end
    return tally
  end

end
