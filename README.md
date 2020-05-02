# DEV DOCS

Crazy eights

5 cards per player,
deck in middle
one card face up thats not eight

players take turns to put down a card that matches
the suit OR the number

if they cannot match, they must pickup
if the deck is empty, they must pass

a player can pickup and not play a card

eights are wild, need to specify suit once played

firs player to run out of cards wins
collects points from other players hand

50 for 8s
10 for courts
pips for rest

----------------------

Game class
 - logic handle
 - @top_card
 - @suit
 - @currentplayer
 - @player_array
 - @numrounds

Player class
 - cards in hand
 - score
 - @player number
 - @name
 - @hand
 - @score

Deck class 
 - THE DECK OF CARDS

-----------------------

- add player method:
input: player number, name
output: player instance (read class instance var)

+ player deal process: 
 read 5 random cards from the deck into var
 use that variable to delete those 5 random cards from the deck
 add those cards to the player hand

	- Game Class Deck Reader
	input: number of cards to randomly select
	output: an array of cards equal to input

	- Game Class Assigner
	input: array of cards and player to assign
	cards to.
	output: Should be able to read the hand of player

	- Game Class Deleter(array, classcvararray)
	input: array to be deleted from deck
	output: smaller deck

+ Game Setup:
 Turn one card faceup, cannot be an 8
	
	- Game class deck reader
	As above

	- Validator(inputcard, @top_card, default=false)
	input: 8, top_card 8, true
	output: boolean

+ Turn Process:

	- Player selection
	Selects the current player using a count

	- Card lister
	prettily list cards
	
	- Card selection
	take an input, match that to a card in hand
	return the card, if PASS, account for that
	
	- Validator
	takes selected card, compares to top card for
	suit and number and 8's, if PASS, account for that

	- IF PASS, add new card to deck

	- Game Class Deleter
	takes selected card if valid, deletes from hand

	= IF 8, suit selection
	If player has chosen an 8, they can now choose suit

	- Suit Validator
	Takes input, sets suit if acceptable

	- Hand check for victory
	Checks current hand if it's zero, if so, game will end

+ Victory Process

	- for every player in the game that isn't the
	selected player, we need to add up their cards
	
	- Victory method(playerarray)
	50 for 8s
	10 for courts
	pips for rest
	returns a value to be assigned to current player
	score

	
	




