require 'rubygems'
require 'pry'
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
		return card
	end
end

class Card
	attr_reader :value, :suit, :rank
	def initialize (value, suit, rank)
		@card = []
		@value = value 
		@suit = suit 
		@rank = rank
	end

	def pretty_output
		puts "The #{value} of #{suit}"
	end

	def to_s
		pretty_output
	end
end

class Player
	attr_accessor :name, :hand, :card, :score
	def initialize(name)
		@name = name 
		@hand = []
		@score = 0
	end
	def display_hand
		puts "#{name}'s hand:"
		@hand.each do |card|
			card.to_s
		end
		puts "With a total of: #{hand_total} "
	end

	def hand_total
		score = 0 
		value = @hand.map do |cards|
			 cards.value
		end

		value.each do |value|
			if value == "A"
				score += 11
			elsif 
				value.to_i == 0
				score += 10
			else 
				score += value.to_i
			end
		end

		value.select{|value| value == "A"}.count.times do
			break if score <= 21
				score -=10
			end
		 @score = score
		 return @score
		end

	def is_busted?
    hand_total > Blackjack::BLACKJACK
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
	def display_hand_hidden
		puts "#{name}'s hand:"
		puts "#{name}'s first card is hidden"
		puts "#{name}'s second card is #{hand[1].value} of #{hand[1].suit}"
		# second_card = hand[1]
		# puts second_card
	end 

end


class Blackjack
	attr_accessor :deck, :player, :cpu
	BLACKJACK = 21
	DEALER_HIT_MIN = 16

	def initialize
		@player = Human.new('Arnold')
		@cpu = Computer.new('Hal 9000')
		@deck = Deck.new
	end

	def set_player_name
		puts "What's your name?"
		player.name = gets.chomp.to_s
	end

	def deal_cards
		@deck.deal(@player)
		@deck.deal(@cpu)
		@deck.deal(@player)
		@deck.deal(@cpu)
	end

	def show_flop
		player.display_hand
		cpu.display_hand_hidden
	end

	def blackjack_or_bust?(player_or_dealer)
		if player_or_dealer.hand_total == 21
			if player_or_dealer.is_a?(Computer)
				puts "Sorry #{player.name}, dealer hit BlackJack. #{player.name} loses. "
			else 
				puts "Congratulations, you hit Blackjack! #{player.name} wins!"
				exit
			end
		elsif player_or_dealer.is_busted?
			if player_or_dealer.is_a?(Computer)
				puts "Congratulations dealer busted. #{player.name} wins! "
			else 
				puts "Sorry you busted. #{player.name} loses!"
			end
			exit
		end
	end

	def player_turn

		blackjack_or_bust?(player)
		while !player.is_busted?
			puts "#{player.name}'s turn you currently have #{player.score} what would you like to do?"
			puts "Would you like to 1) Hit or 2) Stay"
			choice = gets.chomp.to_s
			
			if !["1","2"].include?(choice)
				puts "Error: you must type 1 or 2."
				next
			end
			if choice == '2'
				puts "#{player.name} chose to stay."
				break
			end

			new_card = @deck.deal(player)
			puts "You are dealt a #{new_card.value} of #{new_card.suit}" 
			puts "You're total is #{player.hand_total}"

			blackjack_or_bust?(player)
		end
		puts "#{player.name} stays"
	end

	def computer_turn
		blackjack_or_bust?(cpu)
		puts "It is #{cpu.name}'s turn"
		while cpu.hand_total < DEALER_HIT_MIN
			puts "#{cpu.name} hits"	
			new_card = @deck.deal(cpu)
			puts "#{cpu.name} got dealt #{new_card.value} of #{new_card.suit}"
			puts "#{cpu.name} has a total of #{cpu.hand_total}"
			blackjack_or_bust?(cpu)
		end
		if !cpu.is_busted? && cpu.hand_total > DEALER_HIT_MIN
			puts "#{cpu.name} stays"
			puts cpu.display_hand
		else
			cpu.is_busted?
			puts "#{cpu.name} is busted. #{player.name} wins!"
		end
	end

	def who_won?
		if cpu.hand_total > player.hand_total
			puts "Sorry #{cpu.name} won, you lose."
		elsif cpu.hand_total < player.hand_total
			puts "Congratulations #{player.name} won!"
		else
			puts "It's a tie!"
		end
	end

	def play_again?
		puts "Would you like to play again?"
		puts "1) Yes, 2) No"
		choice = gets.chomp.to_s
		if !["1","2"].include?(choice)
			puts "You must choose 1 or 2"
		elsif choice == "1"
			puts "Starting new game"
			player.hand = []
			cpu.hand = []
			deck = Deck.new
			start
		else 
			puts "Goodbye"
		end
	end

	def intro 
		puts "Welcome to Black Jack"
	end

	def start
		self.intro
		deck.shuffle!
		set_player_name
		deal_cards
		show_flop
		player_turn
		computer_turn
		who_won?
		play_again?
	end

end
game = Blackjack.new
game.start