require 'test/unit'

require_relative '../classes/deck'
require_relative '../classes/game'
require_relative '../classes/player'

class GameTest < Test::Unit::TestCase

  def test_player_add

    game = Game.new
    game.add_player("Nick")
    assert_equal(1, game.player_array.length)

    game = Game.new
    game.add_player("Nick")
    game.add_player("Samuel")        
    assert_equal(2, game.player_array.length)

  end
  
  def test_deck_reader

    game = Game.new
    hand = game.deck_reader(5)
    assert_equal(5, hand.size)

    hand = game.deck_reader(7)
    assert_equal(7, hand.size)

  end

  def test_deleter

    game = Game.new
    inputarr = ["H2"]
    game.deleter(inputarr, game.deck.deck)
    assert_equal(51, game.deck.deck.size)

    game = Game.new
    inputarr = ["H2", "C7", "SQ", "DJ"]
    game.deleter(inputarr, game.deck.deck)
    assert_equal(48, game.deck.deck.size)

  end

  def test_validator

    #Case: Start of game, valid
    game = Game.new
    input = "H7"
    assert_equal(true, game.validator(input,game.top_card, true))

    #Case: Start of game, invalid
    game = Game.new
    input = "H8"
    assert_equal(false, game.validator(input,game.top_card, true))
    
    #Case: In turn, valid selection
    game = Game.new
    input = "H7"
    game.top_card = "H9"
    assert_equal(true, game.validator(input, game.top_card))

    #Case: In turn, invalid selection
    game = Game.new
    input = "C6"
    game.top_card = "H9"
    assert_equal(false, game.validator(input, game.top_card))

    #Case: In turn, valid selection
    game = Game.new
    input = "PASS"
    game.top_card = "H9"
    assert_equal(true, game.validator(input, game.top_card))
    
  end

  def test_player_selector

    game = Game.new
    game.add_player("Nick")
    game.add_player("Samuel")
    game.add_player("Judy")
    game.add_player("Kara")
    game.player_select
    assert_equal(0, game.current_player)

    game = Game.new
    game.add_player("Nick")
    game.add_player("Samuel")
    game.add_player("Judy")
    game.add_player("Kara")
    game.current_player = 2
    game.player_select
    assert_equal(3, game.current_player)

    game = Game.new
    game.add_player("Nick")
    game.add_player("Samuel")
    game.add_player("Judy")
    game.add_player("Kara")
    game.current_player = 3
    game.player_select
    assert_equal(0, game.current_player)

  end

  def test_suit_selector

    game = Game.new
    game.suit = game.suit_select("Spades")
    assert_equal("Spades", game.suit)

    game = Game.new
    game.suit = game.suit_select("Hearts")
    assert_equal("Hearts", game.suit)

    exception = assert_raise {game.suit_select("fbewuaidenawi")}
    assert_equal("That is an invalid selection", exception.message)

  end

  def test_check_for_win

    game = Game.new
    game.add_player("Nick")
    game.add_player("Samuel")
    game.current_player = 0
    game.player_array[game.current_player].hand = []
    assert_equal(false, game.check_for_win)

    game = Game.new
    game.add_player("Nick")
    game.add_player("Samuel")
    game.current_player = 0
    game.player_array[game.current_player].hand = ["H2","C8","DQ","DJ"]
    assert_equal(true, game.check_for_win)

  end

  def test_scoring

    game = Game.new
    game.add_player("Nick")
    game.player_array[0].hand = []

    game.add_player("Samuel")
    game.player_array[1].hand = ["H2","C8"]

    game.add_player("Judy")
    game.player_array[2].hand = ["DQ","DJ"]

    game.player_array[0].score += game.victory_score

    assert_equal(30, game.player_array[0].score)

  end

end

class PlayerTest < Test::Unit::TestCase

  def test_hand_assignment

    hand = ["H2","C8","DQ","DJ"]
    player = Player.new("Nick")
    player.hand = hand
    assert_equal(["H2","C8","DQ","DJ"], player.hand)

    hand = ["C2","D8","SQ","HJ"]
    player = Player.new("Nick")
    player.hand = hand
    assert_equal(["C2","D8","SQ","HJ"], player.hand)

  end

  def test_card_selection

    hand = ["H2","C8","DQ","DJ"]
    player = Player.new("Nick")
    player.hand = hand
    assert_equal("H2", player.card_select("H2"))
    assert_equal("PASS", player.card_select("PASS"))

    exception = assert_raise(StandardError) {player.card_select("fbewuaidenawi")}
    assert_equal("That is an invalid selection", exception.message)

  end

end