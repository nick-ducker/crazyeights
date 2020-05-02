require_relative 'deck'
require_relative 'player'
require_relative '../module/scorehash'

class Game

  attr_reader :player_array
  attr_accessor :top_card, :deck, :current_player, :suit

  include ScoreHash

  def initialize

    @player_array = Array.new
    @numrounds = 3
    
  end

  def start
    system 'clear'
    add_player_prompt()

    @numrounds.times do
      @deck = Deck.new
      @suit = nil
      @top_card = nil
      @selected_card = nil
      @current_player = nil
      deal_cards()

      top_card_select()
      suit_read()      

      running = true
      while running
        player_select()
        print_game_state()
        print_hand()
        card_select_prompt()

        if check_for_eight()
          suit_prompt()
          @top_card = @selected_card
        elsif @selected_card == "PASS"
          @player_array[@current_player].hand << add_card_to_hand()
        else
          @top_card = @selected_card
          suit_read()        
        end
        running = check_for_win()

      end

      @player_array[@current_player].score += victory_score

        puts "#{@player_array[@current_player].name} won! Their score is now #{@player_array[@current_player].score}"
        puts "press enter to continue"
        gets
    end

    puts "Final Scores:"
    @player_array.each {|x| puts "#{x.name} : #{x.score}"}

  end

  def add_card_to_hand
    if @deck.deck.empty?
      return nil
    else 
      card = deck_reader(1)
      deleter(card, @deck.deck)
      return card[0]
    end
  end

  def check_for_eight
    @selected_card[1] == "8" ? true : false
  end

  def suit_prompt
    puts "Please select a suit"
    puts "Hearts, Diamons, Spades or Clubs"
    begin
      input = suit_select(gets.strip)
    rescue => e
      puts "#{e.message}"
      puts "Please try again"
      retry
    end
    @suit = input
  end

  def card_select_prompt
    running = true
    while running
      puts "Please select a card or [PASS]"
      begin
        input = gets.strip
        @player_array[@current_player].card_select(input)
      rescue => e
        puts "#{e.message}"
        puts "Please choose again"
        retry
      end

      if validator(input,@top_card)
        @selected_card = input
        running = false
      else
        puts "That isn't a valid selection"
        running = true
      end

      deleter(@selected_card,@player_array[@current_player].hand)
    end
  end

  def print_game_state
    system 'clear'
    puts "It's #{@player_array[@current_player].name}'s turn"
    puts "Suit: #{@suit}"
    puts "Current Card: #{@top_card}"
    puts
  end

  def print_hand
    puts "Hand: #{@player_array[@current_player].hand}"
    puts
  end

  def top_card_select
    running = true
    while running
      @top_card = deck_reader(1)[0]
      validator(@top_card, @top_card, true) ? (running = true) : (running = false)
    end
    deleter(@top_card, @deck.deck)
  end

  def deal_cards
    @player_array.each do |x|
      cards = deck_reader(5)
      x.hand = cards
      deleter(cards, @deck.deck)
    end
  end

  def add_player_prompt
    begin
      puts "How many players would you like to add?"
      input = Integer(gets)
      raise StandardError if input == 0 || input == 1
    rescue
      puts "That is not a valid input"
      retry
    end

    count = 1
    input.times do
      system 'clear'
      puts "Enter a name for player #{count}"
      name = gets.strip
      add_player(name)
      count += 1
    end

  end

private

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
    if inputarr.class != Array
      arr.delete(inputarr) 
    else    
      inputarr.each {|x| arr.delete(x)} 
    end
  end

  def validator(input, top_card, bool=false)
    return input.include?("8") if bool
    return true if input == "PASS"
    return true if input[0] == @suit[0] || input[1] == top_card[1] || input[1] == "8"
    return false
  end

  def player_select
    if @current_player == nil || @current_player == (@player_array.length - 1)
      @current_player = 0
    else
      @current_player += 1  
    end  
  end

  def suit_read
    suits = {"H" => "Hearts", "D" => "Diamonds", "S" => "Spades", "C" => "Clubs"}
    @suit = suits[@top_card[0][0]]
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

Game.new.start
