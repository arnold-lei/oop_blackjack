# Dealer and Player are dealt 2 cards each 
# Player can choose hit (get dealt another card) or stay (calculate your hand)
# Dealer will hit until he is =< 16. Then he stays
# Both Players calculate thier hand totals and compare. 
# Player with the highest score under 21 wins
# player can choose to play again

#@deck = [[hearts, 1], [heart, 2],...]

class Deck
	attr_accessor :deck, :card
	attr_reader :values, :suits 
	def initialize
		@card = []
		@values = %w{2 3 4 5 6 7 8 9 J Q K A}
		@suits = %w{♦ ♣ ♥ ♠}
		@suits.each do |suit|
			(@values).each do |value|
				@card << Card.new(value, suit,)
			end
		end		
	end
	
	def shuffle!
		card.shuffle!
	end
	
	def deal(player)
		card.pop
	end
end

class Card
	attr_reader :value, :suit
	def initialize (value, suit)
		@card = []
		@value = value 
		@suit = suit 
	end

	def pretty_output
		puts "The #{value} of #{suit}"
	end

	def to_s
		pretty_output
	end
end

class Player
	attr_accessor :name, :hand
	def initialize(name)
		@name = name 
		@hand = []
	end
	def display_hand
		@hand.each do |card|
			card.to_s
		end
	end
	def hand_total
		value = @hand.each do |cards|
			 cards
		end
		puts value
	end
end

class Human < Player
	def initialize(name)
		@hand = []
		super
	end
end

class Computer < Player
	def initialize(name)
		@hand = []
		super
	end
end

class Game
	def initialize
		@player = Human.new('Arnold')
		@cpu = Computer.new('Hal 9000')
		@deck = Deck.new
	end

	def calc_winner

	end

	def intro 
		puts "Welcome to Black Jack"
	end
	def play
		intro 
		@deck.shuffle!
		@deck.deal(@player)
		@deck.deal(@cpu)
		@deck.deal(@player)
		@deck.deal(@cpu)

		puts @cpu.name
		@cpu.display_hand
		@cpu.hand_total

		puts @player.name
		@player.display_hand
		@player.hand_total


	end
end
game = Game.new.play