# Dealer and Player are dealt 2 cards each 
# Player can choose hit (get dealt another card) or stay (calculate your hand)
# Dealer will hit until he is =< 16. Then he stays
# Both Players calculate thier hand totals and compare. 
# Player with the highest score under 21 wins
# player can choose to play again

#@deck = [[hearts, 1], [heart, 2],...]

class Deck
	attr_accessor :deck
	attr_reader :values, :suits 
	def initialize
		@deck = []
		@values = %w{2 3 4 5 6 7 8 9 J Q K A}
		@suits = %w{♦ ♣ ♥ ♠}
		@suits.each do |suit|
			(@values.size).times do |card|
				@deck.push(Card.new(values[card], suit, (card+1)))
			end
		end		
	end
	
	def shuffle!
		@deck.shuffle!
	end
	
	def deal(player)
		card = @deck.pop
		player.hand << card
	end
end

class Card
	attr_reader :value, :suit, :rank
	def initialize (value, suit, rank)
		@value = value 
		@suit = suit 
		@rank = rank
	end
	
	def to_s
		p "The #{value} #{@suit}"
	end
end

class Player
	attr_accessor :name, :hand
	def initialize(name)
		@name = name 
		@hand = []
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

	def deal
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
		p @cpu.hand

		puts @player.name
		p @player.hand
	end
end
game = Game.new.play