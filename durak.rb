class Card # make card
	attr_reader :suit, :name, :value, :b_line1, :b_line2, #the attributes of card that can be read
	:b_line3, :b_line4, :b_line5, :b_line6, :b_line7,
	:line1, :line2, :line3, :line4, :line5, :line6, :line7
	attr_accessor :canplay #the attribute of card that can be read and written

	def initialize(suit, value, name, line2, line3, line4, line5, line6)
		@suit = suit #card suit
		@value = value #value acording to face
		@name = name #name to print to console
		@canplay = false #unless card meets certian conditions it cannot be played

		@b_line1 = "╔═══════╗"
		@b_line2 = "║╔═════╗║"
		@b_line3 = "║║* * *║║"
		@b_line4 = "║║ * * ║║"
		@b_line5 = "║║* * *║║"
		@b_line6 = "║╚═════╝║"
		@b_line7 = "╚═══════╝"

		@line1 = b_line1
		@line2 = line2
		@line3 = line3
		@line4 = line4
		@line5 = line5
		@line6 = line6
		@line7 = b_line7
	end 
end

class Game
	def initialize()
		@deck = create_deck #create array of 32 cards
		@phand =[] #create empty array for player
		@ohand =[] #create empty array for player
		@first = true #establish first turn as different 
		@attacker = "" #designates player or opponent as attacker
		@initial = true #sets up initial attack
		
		@attack = [] #set holder for attacing cards
		@defend = [] #set holder for defending cards

		shuffle() #randomly order deck array
	end
	
	def shuffle #randomly order deck array
		@deck.length.times{|x| #get location of cards in order
			location = rand(@deck.length) #get place of random card
			temp = @deck[location] #hold random card
			@deck[location] = @deck[x] #put random card in current location
			@deck[x] = temp #put card from current location in random location
		}
		
		deal() #fill player and opponent arrays
	end
	
	def deal
		6.times{ #give each player 6 cards from the top of the deck
			@phand << @deck.shift #put next card in player hand
			@ohand << @deck.shift #put next card in opponet hand
		}
		@trump = @deck[-1] #set trump to suit of bottom card
		order() #put player cards in order of value
		turn() #determine who goes first
	end

	def order()
		ordered = [] #empty array for player cards in order
		club_ary = [] #empty array for clubs
		diamond_ary = [] #empty array for diamonds
		heart_ary = [] #empty array for hearts
		spade_ary = [] #empty array for spades

		@phand.each{|x|
			if x.suit == "club" #identify clubs
				club_ary << x #put all clubs into club array
			elsif x.suit == "diamond" #identify diamonsd
				diamond_ary << x #put all diamonds into diamond array
			elsif x.suit == "heart" #identify heartss
				heart_ary << x #put all hearts into heart array
			elsif x.suit == "spade" #identify spades
				spade_ary << x #put all spades into spade array
			end}

		club_ary = club_ary.sort_by{|x| x.value}.reverse #sort clubs by card value
		diamond_ary = diamond_ary.sort_by{|x| x.value}.reverse #sort diamonds by card value
		heart_ary = heart_ary.sort_by{|x| x.value}.reverse #sort heartss by card value
		spade_ary = spade_ary.sort_by{|x| x.value}.reverse #sort spades by card value
		
		if @trump.suit == "club" #if #trump is club put clubs first
			club_ary.each{|x| ordered << x}
			diamond_ary.each{|x| ordered << x}
			heart_ary.each{|x| ordered << x}
			spade_ary.each{|x| ordered << x}
		elsif @trump.suit == "diamond" #if #trump is diamond put diamonds first
			diamond_ary.each{|x| ordered << x}
			club_ary.each{|x| ordered << x}
			heart_ary.each{|x| ordered << x}
			spade_ary.each{|x| ordered << x}
		elsif @trump.suit == "heart" #if #trump is heart put hearts first
			heart_ary.each{|x| ordered << x}
			diamond_ary.each{|x| ordered << x}
			club_ary.each{|x| ordered << x}
			spade_ary.each{|x| ordered << x}
		elsif @trump.suit == "spade" #if #trump is spade put spades first
			spade_ary.each{|x| ordered << x}
			heart_ary.each{|x| ordered << x}
			diamond_ary.each{|x| ordered << x}
			club_ary.each{|x| ordered << x}
		end

		@phand = ordered
	end

	def ocards #show opponent cards
		oline1 = oline2 = oline3 = oline4 = oline5 = oline6 = oline7 = "" #initialze strings that will show oponent cards 

		@ohand.count.times{|x| oline1 += "  #{@ohand[x].b_line1}"} #fill opponent strings
		@ohand.count.times{|x| oline2 += "  #{@ohand[x].b_line2}"}
		@ohand.count.times{|x| oline3 += "  #{@ohand[x].b_line3}"}
		@ohand.count.times{|x| oline4 += "  #{@ohand[x].b_line4}"}
		@ohand.count.times{|x| oline5 += "  #{@ohand[x].b_line5}"}
		@ohand.count.times{|x| oline6 += "  #{@ohand[x].b_line6}"}
		@ohand.count.times{|x| oline7 += "  #{@ohand[x].b_line7}"}
		
		puts "#{oline1}" #display opponent cards face down
		puts "#{oline2}"
		puts "#{oline3}"
		puts "#{oline4}"
		puts "#{oline5}"
		puts "#{oline6}"
		puts "#{oline7}"	
	end 

	def setup #show cads in play 
		
		ocards() #show oponents hand 
#put dynamic spacing here "                 "
		inplay0 = inplay1 = inplay2 = inplay3 = inplay4 = inplay5 = inplay6 = inplay7 = inplay8 = inplay9 ="        " #initilize lines for cards in play

		@attack.count.times{|x| inplay0 += "  #{@attack[x].line1}"} #make a string of attacking cards in play
		@attack.count.times{|x| inplay1 += "  #{@attack[x].line2}"}
		@attack.count.times{|x| inplay2 += "  #{@attack[x].line3}"}
		@attack.count.times{|x| 
			if @defend.count >= x && @defend.count != 0
				inplay3 += "  #{@defend[x].line1}" 
			else
				inplay3 += "  #{@attack[x].line4}"
			end}	
		@attack.count.times{|x| 
			if @defend.count >= x && @defend.count != 0
				inplay4 += "  #{@defend[x].line2}" 
			else
				inplay4 += "  #{@attack[x].line5}"
			end}
		@attack.count.times{|x| 
			if @defend.count >= x && @defend.count != 0
				inplay5 += "  #{@defend[x].line3}" #covers attacking card with defending card
			else
				inplay5 += "  #{@attack[x].line6}"
			end}
		@attack.count.times{|x| 
			if @defend.count >= x && @defend.count != 0
				inplay6 += "  #{@defend[x].line4}"
			else
				inplay6 += "  #{@attack[x].line7}"
			end}
		@attack.count.times{|x|
			if @defend.count >= x && @defend.count != 0
				inplay7 += "  #{@defend[x].line5}"
			else
				inplay7 += "           "
			end}
		@attack.count.times{|x| 
			if @defend.count >= x && @defend.count != 0
				inplay8 += "  #{@defend[x].line6}"
			end}
		@attack.count.times{|x| 
			if @defend.count >= x && @defend.count != 0
				inplay9 += "  #{@defend[x].line7}"
			end}
		
		spaces = "                   "
		inplay0 += "#{spaces}           T R U M P"
		inplay1 += "#{spaces}#{@deck[0].b_line1}  #{@deck[-1].line1}" #show bottom card as trump
		inplay2 += "#{spaces}#{@deck[0].b_line2}  #{@deck[-1].line2}"
		inplay3 += "#{spaces}#{@deck[0].b_line3}  #{@deck[-1].line3}"
		inplay4 += "#{spaces}#{@deck[0].b_line4}  #{@deck[-1].line4}"
		inplay5 += "#{spaces}#{@deck[0].b_line5}  #{@deck[-1].line5}"
		inplay6 += "#{spaces}#{@deck[0].b_line6}  #{@deck[-1].line6}"
		inplay7 += "#{spaces}#{@deck[0].b_line7}  #{@deck[-1].line7}"
		if @deck.count != 0 
			inplay8 += "#{spaces}     #{@deck.count}" #shows cards remaining in deck
		end

		puts "#{inplay0}" # display cards in play
		puts "#{inplay1}"
		puts "#{inplay2}"
		puts "#{inplay3}"
		puts "#{inplay4}"
		puts "#{inplay5}"
		puts "#{inplay6}"
		puts "#{inplay7}"
		puts "#{inplay8}"
		puts "#{inplay9}"

# 		if @attack.count == 0 # display if no cards have been played
# 			puts "\n"
# 			puts "                                                        T R U M P"
# 			puts "                                             #{@deck[0].b_line1}  #{@deck[-1].line1}" #show bottom card as trump
# 			puts "                                             #{@deck[0].b_line2}  #{@deck[-1].line2}"
# 			puts "                                             #{@deck[0].b_line3}  #{@deck[-1].line3}"
# 			puts "                                             #{@deck[0].b_line4}  #{@deck[-1].line4}"
# 			puts "                                             #{@deck[0].b_line5}  #{@deck[-1].line5}"
# 			puts "                                             #{@deck[0].b_line6}  #{@deck[-1].line6}"
# 			puts "                                             #{@deck[0].b_line7}  #{@deck[-1].line7}"
# 			puts "\n"
# 			puts "\n"
# #make a string for defending cards below needs to be rewritten
# 		elsif @defend.count == 0 #display if 1 card has been played
# 			puts "\n"
# 			puts "                 #{@attack.line1}                              T R U M P"
# 			puts "                 #{@attack.line2}                   #{@deck[0].b_line1}  #{@deck[-1].line1}"
# 			puts "                 #{@attack.line3}                   #{@deck[0].b_line2}  #{@deck[-1].line2}"
# 			puts "                 #{@attack.line4}                   #{@deck[0].b_line3}  #{@deck[-1].line3}"
# 			puts "                 #{@attack.line5}                   #{@deck[0].b_line4}  #{@deck[-1].line4}"
# 			puts "                 #{@attack.line6}                   #{@deck[0].b_line5}  #{@deck[-1].line5}"
# 			puts "                 #{@attack.line7}                   #{@deck[0].b_line6}  #{@deck[-1].line6}"
# 			puts "                                             #{@deck[0].b_line7}  #{@deck[-1].line7}"
# 			puts "\n"
# 			puts "\n"
# 		else #display if 2 cards have been played
# 			puts "\n"
# 			puts "                 #{@attack.line1}                              T R U M P"
# 			puts "                 #{@attack.line2}                   #{@deck[0].b_line1}  #{@deck[-1].line1}"
# 			puts "                 #{@attack.line3}                   #{@deck[0].b_line2}  #{@deck[-1].line2}"
# 			puts "                 #{@defend.line1}                   #{@deck[0].b_line3}  #{@deck[-1].line3}"
# 			puts "                 #{@defend.line2}                   #{@deck[0].b_line4}  #{@deck[-1].line4}"
# 			puts "                 #{@defend.line3}                   #{@deck[0].b_line5}  #{@deck[-1].line5}"
# 			puts "                 #{@defend.line4}                   #{@deck[0].b_line6}  #{@deck[-1].line6}"
# 			puts "                 #{@defend.line5}                   #{@deck[0].b_line7}  #{@deck[-1].line7}"
# 			puts "                 #{@defend.line6}"
# 			puts "                 #{@defend.line7}"
# 		end

		pcards() #show players hand
	end

	def pcards
		pline1 = pline2 = pline3 = pline4 = pline5 = pline6 = pline7 = "" #initialze strings that will show oponent cards

		@phand.count.times{|x| pline1 += "  #{@phand[x].line1}"} #create player strings
		@phand.count.times{|x| pline2 += "  #{@phand[x].line2}"}
		@phand.count.times{|x| pline3 += "  #{@phand[x].line3}"}
		@phand.count.times{|x| pline4 += "  #{@phand[x].line4}"}
		@phand.count.times{|x| pline5 += "  #{@phand[x].line5}"}
		@phand.count.times{|x| pline6 += "  #{@phand[x].line6}"}
		@phand.count.times{|x| pline7 += "  #{@phand[x].line7}"}
		
		if @attack.count != 0 #player can always take cards in play
			pline7 += "    TAKE" 
		end
		if @attack.count != 0 && @attack.count==@defend.count
			pline7 += "  DISCARD"
		end
		puts "\n" #if card can be played shift it up 1 row
		puts "#{pline1}" #display player cards face up
		puts "#{pline2}"
		puts "#{pline3}"
		puts "#{pline4}"
		puts "#{pline5}"
		puts "#{pline6}"
		puts "#{pline7}"
	end 

	def turn #determines if player or opponent go first
		if @first 
			@first = false #run first turn 1 time
			
			#find lowest trump to go first
			ptrump = 20 #compare value of cards in player's hand to high number
			otrump = 20 #compare value of cards in player's hand to high number
			
			@ohand.each{|x| #search oponents hand for lowest trump
				if x.suit == @trump.suit #only look at trump suit
					if x.value < otrump #compare value of trum cards
						otrump = x.value #keep value of lowest trump
					end
				end}

			@phand.each{|x| #search players hand for lowest trump
				if x.suit == @trump.suit #only look at trump suit
					if x.value < ptrump #compare value of trum cards
						ptrump = x.value ##keep value of lowest trump
					end
				end}
			if ptrump < otrump #prompt either player or opponent to go first
				@attacker = "player"
			else
				@attacker = "opponent"
			end
		end
		launch_atk()
	end
#TURN LOGIC
	def launch_atk #attacker plays card
		setup()
		if @attacker == "player"
			options = 0 #player choices
			cardid = "      " #empty sring to identify cards for the user
			
			@phand.count.times{|x| #put numbers under player cards
				if x==0
					cardid  += "#{x+1}"
					options = x+1 #set player choice numbers
				else
					cardid  += "          #{x+1}" 
					options = x+1 #increase with number of cards
				end}
			puts cardid
			puts "You are the attacker. Choose a card."

			validinput = false #verify input
			until validinput
				card = gets.chomp.to_i 
				card -= 1 #get user input in a form that matches array index

				if card.class != Fixnum || card > options || card < 0 #define valid input
					puts "Please choose a card with #{(1..@phand.count-1).to_a.join(", ")}, or #{@phand.count}."#give player feedback
				else
					validinput = true
				end
			end
			@attack << @phand[card] #put attacking card in attacking array
			@phand.delete_at(card) #remove card from player hand
		else
			num = 20 #set arbitraty high number for comparison
			temp = nil #place holder for opponent's card
			
			alltrump = true #check to see if all oponent's cards are trump
			@ohand.each{|y|
				if y.suit != @trump.suit
					alltrump = false
				end}
			
			@ohand.each{|x| #search opponent hand for appropriate card
				if alltrump #if opponent only has trum, they will play trump
					if x.value < num
						temp = x
					end
				elsif x.suit != @trump.suit #opponent will try not to lead with somthing other than trump
					if x.value < num
						temp = x
					end
				end}
			@attack << temp
			puts "Opponent attacks with #{temp.name}."
			@ohand.delete(temp)
		end
		setup()
		mount_def()
	end
 
	def mount_def()
		puts "Attacking works!!! Yay!!!"
	end

#D 1. Take, 2. Defend 3. Transfer #set initial attack to false
#D 1. Take all cards in play get added to defender's hand #attacker stays attacker
#D 2. Defender plays a trump or higher card of attacking card's suit #attacker can throw in
#D 3. Defender throws card with same value as attack. #Defender becomes attacker

#THROWING IN
#A 1. Attacker discards cards in play 2. Attacker throws a card matching any of the cards in play 
#A 1. Defender becomes attacker, discard cards in play, end turn
#A 2. Add card to attack, defender defends

#DEFENDING THROW IN 
#D 1. Take, 2. Defend 
#D 1. Take all cards in play get added to defender's hand #attacker stays attacker
#D 2. Defender plays a trump or higher card of attacking card's suit #attacker can throw in

#END TURN
# If there are cars in the deck make sure attacker and defender each have 6 cards 

	def playermove
		options = 0 #player choices
		playable() #identify playable cards

		setup() #show game table with playable cards highlighted
		cardid = "      " #empty sring to identify cards for the user
		@phand.count.times{|x| #put numbers under player cards
			if x==0
				cardid  += "#{x+1}"
				options = x+1 #set player choice numbers
			else
				cardid  += "          #{x+1}" 
				options = x+1 #increase with number of cards
			end}
		if @attack.count != 0 #if player can take give them the option
			options = @phand.count+1 #add a choice for take
			cardid  += "          #{options}"
		end

		puts cardid
		if @attacker == "opponent"
			puts "Opponent attacks with #{@attack.name}, chose your defense."
		elsif @attack.count != 0 
			puts "Your opponent defendend with #{@defend[0].name}."
			puts "You can take, transfer, or discard."
		else
			puts "You are the attacker. Choose a card."
		end  

		validinput = false #verify input
		until validinput
			card = gets.chomp.to_i 
			card -= 1 #get user input in a form that matches array index

			if @attack.count > 0 && card == options-1 #when player takes put all cards in play in player hand
				@phand += @attack #give player all attacking cards
				@phand += @defend #give player all defending cards
				@attack = [] #remove all attacking cards
				@defend = [] #remove all defending cards
				@attack = "opponent"
				validinput = true
				order()
			elsif card.class != Fixnum || card > options || card < 0
				if @attack.count > 0
					puts "Please choose a card with #{(1..@phand.count).to_a.join(", ")}, or take with #{options}."
				else
					puts "Please choose a card with #{(1..@phand.count-1).to_a.join(", ")}, or #{@phand.count}."
				end
			elsif @attack.count !=0
				if @phand[card].canplay == false
					num = @attack.name.split #get the name of the card
					num = num[0].to_s #only get the first part of the name
					puts "To defend you have to play a #{@trump.suit} to trump, or a #{@attack.suit} higher than the #{num}."
					puts "You can also transfer with a #{num} of a different suit."
				end
			else
				validinput = true
			end
		end

		if @turn == "player"
			@attack << @phand[card] #put attacking card in attacking array
			@phand.delete_at(card) #remove card from player hand
		else
			@defend << @phand[card] #put defending card in defending array
			@phand.delete_at(card) #remove card from player hand
		end
		setup()
		opponentmove()
	end

	def playable
		if @attack.count == 0
			@phand.each{|x| x.canplay = false} #if player is attacking first, they can play any card
		else
			@phand.each{|x| #go through player hand
				if x.suit == @trump.suit #player can always trump
					x.canplay = true
#below won't work. need to point to a specific card in attack array
				elsif (x.suit == @attack[0].suit && x.value>@attack[0].value) #player can play a higher card of the same suit
					x.canplay = true
				else
					x.canplay = false
				end}
			@attack.each{|x| #check all attacking cards
				@phand.each{|y|
					if y.value == x.value #Players can 'transfer' if they can match the value of a card in play
						y.canplay = true
					end}}
			@defend.each{|x| #check all defending cards
				@phand.each{|y|
					if y.value == x.value #Players can 'transfer' if they can match the value of a card in play
						y.canplay = true
					end}}
		end
	end

	def opponentmove
		otrump = 20
		if @turn == "player"
			@defend = []
			@ohand.each{|x| #search through all cards in hand 
#below won't work. need to point to a specific card in attack array
				if x.suit == @attack[0].suit
					if x.value > @attack[0].value
						@defend << x #put defending card in defending array
					end
				end}
			@ohand.each{|x|
			if @defend.count == 0
				@ohand.each{|x|
				if x.suit == @trump.suit
					if x.value < otrump
						@defend << x #put defending card in defending array
					end
				end}
			end}

			if @defend.count == 0
				puts "The opponent takes."
				@ohand += @attack #add all attacking cards to oponent's hand
				@ohand += @defend #add all defending cards to oponent's hand
				@attack = [] #clear attack array
				@defend = [] #clear defending array
				@attacker = "player" #player becomes the attacker
			else 
			 	@ohand.delete(@defend[@defend.count-1]) #remove the card just played from the oponent's hand
			end
		else
			num = 20
			temp = nil
			@ohand.each{|x| 
				if x.suit != @trump.suit
					if x.value < num
						temp = x
					end
				end}
			@attack << temp
			@ohand.delete(@attack[@attack.count-1])
		end
		playermove()
	end

	def create_deck
		deck = []
		s6 = Card.new(
			"spade",
			6,
			"six of spades",
			"║6      ║",
			"║ ♠   ♠ ║",
			"║ ♠   ♠ ║",
			"║ ♠   ♠ ║",
			"║      6║"
			)
		deck << s6
		s7 = Card.new(
			"spade",
			7,
			"seven of spades",
			"║7      ║",
			"║ ♠   ♠ ║",
			"║ ♠ ♠ ♠ ║",
			"║ ♠   ♠ ║",
			"║      7║"
			)
		deck << s7
		s8 = Card.new(
			"spade",
			8,
			"eight of spades",
			"║8      ║",
			"║ ♠ ♠ ♠ ║",
			"║  ♠ ♠  ║",
			"║ ♠ ♠ ♠ ║",
			"║      8║"
			)
		deck << s8
		s9 = Card.new(
			"spade",
			9,
			"nine of spades",
			"║9      ║",
			"║ ♠ ♠ ♠ ║",
			"║ ♠ ♠ ♠ ║",
			"║ ♠ ♠ ♠ ║",
			"║      9║"
			)
		deck << s9
		s10 = Card.new(
			"spade",
			10,
			"ten of spades",
			"║10     ║",
			"║♠ ♠ ♠ ♠║",
			"║ ♠   ♠ ║",
			"║♠ ♠ ♠ ♠║",
			"║     10║"
			)
		deck << s10
		sJ = Card.new(
			"spade",
			11,
			"jack of spades",
			"║J      ║",
			"║ A  ♠  ║",
			"║   C   ║",
		    "║  ♠  K ║",
			"║      J║"
			)
		deck << sJ
		sQ = Card.new(
			"spade",
			12,
			"queen of spades",
			"║Q      ║",
			"║ °\\♠/° ║",
		    "║  |°|  ║",
		    "║ @@@@@ ║",
			"║      Q║"
			)
		deck << sQ
		sK = Card.new(
			"spade",
			13,
			"king of spades",
			"║K      ║",
			"║ ♠ ♠ ♠ ║",
			"║ |VVV| ║",
		    "║ |___| ║",
			"║      K║"
			)
		deck << sK
		sA = Card.new(
			"spade",
			14,
			"ace of spades",
			"║A♠     ║",
			"║       ║",
			"║   ♠   ║",
		    "║       ║",
			"║     ♠A║"
			)
		deck << sA
		c6 = Card.new(
			"club",
			6,
			"six of clubs",
			"║6      ║",
			"║ ♣   ♣ ║",
			"║ ♣   ♣ ║",
			"║ ♣   ♣ ║",
			"║      6║"
			)
		deck << c6
		c7 = Card.new(
			"club",
			7,
			"seven of clubs",
			"║7      ║",
			"║ ♣   ♣ ║",
			"║ ♣ ♣ ♣ ║",
			"║ ♣   ♣ ║",
			"║      7║"
			)
		deck << c7
		c8 = Card.new(
			"club",
			8,
			"eight of clubs",
			"║8      ║",
			"║ ♣ ♣ ♣ ║",
			"║  ♣ ♣  ║",
			"║ ♣ ♣ ♣ ║",
			"║      8║"
			)
		deck << c8
		c9 = Card.new(
			"club",
			9,
			"nine of clubs",
			"║9      ║",
			"║ ♣ ♣ ♣ ║",
			"║ ♣ ♣ ♣ ║",
			"║ ♣ ♣ ♣ ║",
			"║      9║"
			)
		deck << c9
		c10 = Card.new(
			"club",
			10,
			"ten of clubs",
			"║10     ║",
			"║♣ ♣ ♣ ♣║",
			"║ ♣   ♣ ║",
			"║♣ ♣ ♣ ♣║",
			"║     10║"
			)
		deck << c10
		cJ = Card.new(
			"club",
			11,
			"jack of clubs",
			"║J      ║",
			"║ A  ♣  ║",
			"║   C   ║",
		    "║  ♣  K ║",
			"║      J║"
			)
		deck << cJ
		cQ = Card.new(
			"club",
			12,
			"queen of clubs",
			"║Q      ║",
			"║ °\\♣/° ║",
		    "║  |°|  ║",
		    "║ @@@@@ ║",
			"║      Q║"
			)
		deck << cQ
		cK = Card.new(
			"club",
			13,
			"king of clubs",
			"║K      ║",
			"║ ♣ ♣ ♣ ║",
			"║ |VVV| ║",
		    "║ |___| ║",
			"║      K║"
			)
		deck << cK
		cA = Card.new(
			"club",
			14,
			"ace of clubs",
			"║A♣     ║",
			"║       ║",
			"║   ♣   ║",
		    "║       ║",
			"║     ♣A║"
			)
		deck << cA
		h6 = Card.new(
			"heart",
			6,
			"six of hearts",
			"║6      ║",
			"║ ♥   ♥ ║",
			"║ ♥   ♥ ║",
			"║ ♥   ♥ ║",
			"║      6║"
			)
		deck << h6
		h7 = Card.new(
			"heart",
			7,
			"seven of hearts",
			"║7      ║",
			"║ ♥   ♥ ║",
			"║ ♥ ♥ ♥ ║",
			"║ ♥   ♥ ║",
			"║      7║"
			)
		deck << h7
		h8 = Card.new(
			"heart",
			8,
			"eight of hearts",
			"║8      ║",
			"║ ♥ ♥ ♥ ║",
			"║  ♥ ♥  ║",
			"║ ♥ ♥ ♥ ║",
			"║      8║"
			)
		deck << h8
		h9 = Card.new(
			"heart",
			9,
			"nine of hearts",
			"║9      ║",
			"║ ♥ ♥ ♥ ║",
			"║ ♥ ♥ ♥ ║",
			"║ ♥ ♥ ♥ ║",
			"║      9║"
			)
		deck << h9
		h10 = Card.new(
			"heart",
			10,
			"ten of hearts",
			"║10     ║",
			"║♥ ♥ ♥ ♥║",
			"║ ♥   ♥ ║",
			"║♥ ♥ ♥ ♥║",
			"║     10║"
			)
		deck << h10
		hJ = Card.new(
			"heart",
			11,
			"jack of hearts",
			"║J      ║",
			"║ A  ♥  ║",
			"║   C   ║",
		    "║  ♥  K ║",
			"║      J║"
			)
		deck << hJ
		hQ = Card.new(
			"heart",
			12,
			"queen of hearts",
			"║Q      ║",
			"║ °\\♥/° ║",
		    "║  |°|  ║",
		    "║ @@@@@ ║",
			"║      Q║"
			)
		deck << hQ
		hK = Card.new(
			"heart",
			13,
			"king of hearts",
			"║K      ║",
			"║ ♥ ♥ ♥ ║",
			"║ |VVV| ║",
		    "║ |___| ║",
			"║      K║"
			)
		deck << hK
		hA = Card.new(
			"heart",
			14,
			"ace of hearts",
			"║A♥     ║",
			"║       ║",
			"║   ♥   ║",
		    "║       ║",
			"║     ♥A║"
			)
		deck << hA
		d6 = Card.new(
			"diamond",
			6,
			"six of diamonds",
			"║6      ║",
			"║ ♦   ♦ ║",
			"║ ♦   ♦ ║",
			"║ ♦   ♦ ║",
			"║      6║"
			)
		deck << d6
		d7 = Card.new(
			"diamond",
			7,
			"seven of diamonds",
			"║7      ║",
			"║ ♦   ♦ ║",
			"║ ♦ ♦ ♦ ║",
			"║ ♦   ♦ ║",
			"║      7║"
			)
		deck << d7
		d8 = Card.new(
			"diamond",
			8,
			"eight of diamonds",
			"║8      ║",
			"║ ♦ ♦ ♦ ║",
			"║  ♦ ♦  ║",
			"║ ♦ ♦ ♦ ║",
			"║      8║"
			)
		deck << d8
		d9 = Card.new(
			"diamond",
			9,
			"nine of diamonds",
			"║9      ║",
			"║ ♦ ♦ ♦ ║",
			"║ ♦ ♦ ♦ ║",
			"║ ♦ ♦ ♦ ║",
			"║      9║"
			)
		deck << d9
		d10 = Card.new(
			"diamond",
			10,
			"ten of diamonds",
			"║10     ║",
			"║♦ ♦ ♦ ♦║",
			"║ ♦   ♦ ║",
			"║♦ ♦ ♦ ♦║",
			"║     10║"
			)
		deck << d10
		dJ = Card.new(
			"diamond",
			11,
			"jack of diamonds",
			"║J      ║",
			"║ A  ♦  ║",
			"║   C   ║",
		    "║  ♦  K ║",
			"║      J║"
			)
		deck << dJ
		dQ = Card.new(
			"diamond",
			12,
			"queen of diamonds",
			"║Q      ║",
			"║ °\\♦/° ║",
		    "║  |°|  ║",
		    "║ @@@@@ ║",
			"║      Q║"
			)
		deck << dQ
		dK = Card.new(
			"diamond",
			13,
			"king of diamonds",
			"║K      ║",
			"║ ♦ ♦ ♦ ║",
			"║ |VVV| ║",
		    "║ |___| ║",
			"║      K║"
			)
		deck << dK
		dA = Card.new(
			"diamond",
			14,
			"ace of diamonds",
			"║A♦     ║",
			"║       ║",
			"║   ♦   ║",
		    "║       ║",
			"║     ♦A║"
			)
		deck << dA
		return deck
	end
end



start = Game.new()
# card=gets.chomp.to_i
# start.playermove(card)
# deck = shuffle(deck)

# puts "#{@deck[0].line1} #{@deck[1].line1} #{@deck[2].line1} #{@deck[3].line1}"
# puts "#{@deck[0].line2} #{@deck[1].line2} #{@deck[2].line2} #{@deck[3].line2}"
# puts "#{@deck[0].line3} #{@deck[1].line3} #{@deck[2].line3} #{@deck[3].line3}"
# puts "#{@deck[0].line4} #{@deck[1].line4} #{@deck[2].line4} #{@deck[3].line4}"
# puts "#{@deck[0].line5} #{@deck[1].line5} #{@deck[2].line5} #{@deck[3].line5}"
# puts "#{@deck[0].line6} #{@deck[1].line6} #{@deck[2].line6} #{@deck[3].line6}"
# puts "#{@deck[0].line7} #{@deck[1].line7} #{@deck[2].line7} #{@deck[3].line7}"

# puts "#{@deck[4].line1} #{@deck[5].line1} #{@deck[6].line1} #{@deck[7].line1}"
# puts "#{@deck[4].line2} #{@deck[5].line2} #{@deck[6].line2} #{@deck[7].line2}"
# puts "#{@deck[4].line3} #{@deck[5].line3} #{@deck[6].line3} #{@deck[7].line3}"
# puts "#{@deck[4].line4} #{@deck[5].line4} #{@deck[6].line4} #{@deck[7].line4}"
# puts "#{@deck[4].line5} #{@deck[5].line5} #{@deck[6].line5} #{@deck[7].line5}"
# puts "#{@deck[4].line6} #{@deck[5].line6} #{@deck[6].line6} #{@deck[7].line6}"
# puts "#{@deck[4].line7} #{@deck[5].line7} #{@deck[6].line7} #{@deck[7].line7}"

# puts "#{@deck[8].line1} #{@deck[9].line1} #{@deck[10].line1} #{@deck[11].line1}"
# puts "#{@deck[8].line2} #{@deck[9].line2} #{@deck[10].line2} #{@deck[11].line2}"
# puts "#{@deck[8].line3} #{@deck[9].line3} #{@deck[10].line3} #{@deck[11].line3}"
# puts "#{@deck[8].line4} #{@deck[9].line4} #{@deck[10].line4} #{@deck[11].line4}"
# puts "#{@deck[8].line5} #{@deck[9].line5} #{@deck[10].line5} #{@deck[11].line5}"
# puts "#{@deck[8].line6} #{@deck[9].line6} #{@deck[10].line6} #{@deck[11].line6}"
# puts "#{@deck[8].line7} #{@deck[9].line7} #{@deck[10].line7} #{@deck[11].line7}"

# puts "#{@deck[12].line1} #{@deck[13].line1} #{@deck[14].line1} #{@deck[15].line1}"
# puts "#{@deck[12].line2} #{@deck[13].line2} #{@deck[14].line2} #{@deck[15].line2}"
# puts "#{@deck[12].line3} #{@deck[13].line3} #{@deck[14].line3} #{@deck[15].line3}"
# puts "#{@deck[12].line4} #{@deck[13].line4} #{@deck[14].line4} #{@deck[15].line4}"
# puts "#{@deck[12].line5} #{@deck[13].line5} #{@deck[14].line5} #{@deck[15].line5}"
# puts "#{@deck[12].line6} #{@deck[13].line6} #{@deck[14].line6} #{@deck[15].line6}"
# puts "#{@deck[12].line7} #{@deck[13].line7} #{@deck[14].line7} #{@deck[15].line7}"

# puts "#{@deck[16].line1} #{@deck[17].line1} #{@deck[18].line1} #{@deck[19].line1}"
# puts "#{@deck[16].line2} #{@deck[17].line2} #{@deck[18].line2} #{@deck[19].line2}"
# puts "#{@deck[16].line3} #{@deck[17].line3} #{@deck[18].line3} #{@deck[19].line3}"
# puts "#{@deck[16].line4} #{@deck[17].line4} #{@deck[18].line4} #{@deck[19].line4}"
# puts "#{@deck[16].line5} #{@deck[17].line5} #{@deck[18].line5} #{@deck[19].line5}"
# puts "#{@deck[16].line6} #{@deck[17].line6} #{@deck[18].line6} #{@deck[19].line6}"
# puts "#{@deck[16].line7} #{@deck[17].line7} #{@deck[18].line7} #{@deck[19].line7}"

# puts "#{@deck[20].line1} #{@deck[21].line1} #{@deck[22].line1} #{@deck[23].line1}"
# puts "#{@deck[20].line2} #{@deck[21].line2} #{@deck[22].line2} #{@deck[23].line2}"
# puts "#{@deck[20].line3} #{@deck[21].line3} #{@deck[22].line3} #{@deck[23].line3}"
# puts "#{@deck[20].line4} #{@deck[21].line4} #{@deck[22].line4} #{@deck[23].line4}"
# puts "#{@deck[20].line5} #{@deck[21].line5} #{@deck[22].line5} #{@deck[23].line5}"
# puts "#{@deck[20].line6} #{@deck[21].line6} #{@deck[22].line6} #{@deck[23].line6}"
# puts "#{@deck[20].line7} #{@deck[21].line7} #{@deck[22].line7} #{@deck[23].line7}"

# puts "#{@deck[24].line1} #{@deck[25].line1} #{@deck[26].line1} #{@deck[27].line1}"
# puts "#{@deck[24].line2} #{@deck[25].line2} #{@deck[26].line2} #{@deck[27].line2}"
# puts "#{@deck[24].line3} #{@deck[25].line3} #{@deck[26].line3} #{@deck[27].line3}"
# puts "#{@deck[24].line4} #{@deck[25].line4} #{@deck[26].line4} #{@deck[27].line4}"
# puts "#{@deck[24].line5} #{@deck[25].line5} #{@deck[26].line5} #{@deck[27].line5}"
# puts "#{@deck[24].line6} #{@deck[25].line6} #{@deck[26].line6} #{@deck[27].line6}"
# puts "#{@deck[24].line7} #{@deck[25].line7} #{@deck[26].line7} #{@deck[27].line7}"

# puts "#{@deck[28].line1} #{@deck[29].line1} #{@deck[30].line1} #{@deck[31].line1}"
# puts "#{@deck[28].line2} #{@deck[29].line2} #{@deck[30].line2} #{@deck[31].line2}"
# puts "#{@deck[28].line3} #{@deck[29].line3} #{@deck[30].line3} #{@deck[31].line3}"
# puts "#{@deck[28].line4} #{@deck[29].line4} #{@deck[30].line4} #{@deck[31].line4}"
# puts "#{@deck[28].line5} #{@deck[29].line5} #{@deck[30].line5} #{@deck[31].line5}"
# puts "#{@deck[28].line6} #{@deck[29].line6} #{@deck[30].line6} #{@deck[31].line6}"
# puts "#{@deck[28].line7} #{@deck[29].line7} #{@deck[30].line7} #{@deck[31].line7}"

# puts "#{@deck[32].line1} #{@deck[33].line1} #{@deck[34].line1} #{@deck[35].line1}"
# puts "#{@deck[32].line2} #{@deck[33].line2} #{@deck[34].line2} #{@deck[35].line2}"
# puts "#{@deck[32].line3} #{@deck[33].line3} #{@deck[34].line3} #{@deck[35].line3}"
# puts "#{@deck[32].line4} #{@deck[33].line4} #{@deck[34].line4} #{@deck[35].line4}"
# puts "#{@deck[32].line5} #{@deck[33].line5} #{@deck[34].line5} #{@deck[35].line5}"
# puts "#{@deck[32].line6} #{@deck[33].line6} #{@deck[34].line6} #{@deck[35].line6}"
# puts "#{@deck[32].line7} #{@deck[33].line7} #{@deck[34].line7} #{@deck[35].line7}"

# c6count = 0
# c7count = 0
# c8count = 0
# c9count = 0
# c10count = 0
# cJcount = 0
# cQcount = 0
# cKcount = 0
# cAcount = 0

# d6count = 0
# d7count = 0
# d8count = 0
# d9count = 0
# d10count = 0
# dJcount = 0
# dQcount = 0
# dKcount = 0
# dAcount = 0

# h6count = 0
# h7count = 0
# h8count = 0
# h9count = 0
# h10count = 0
# hJcount = 0
# hQcount = 0
# hKcount = 0
# hAcount = 0

# s6count = 0
# s7count = 0
# s8count = 0
# s9count = 0
# s10count = 0
# sJcount = 0
# sQcount = 0
# sKcount = 0
# sAcount = 0

# deck.each{|x|
# 	if x.suit == "club" && x.value == 6
# 		c6count += 1
# 	elsif x.suit == "club" && x.value == 7
# 		c7count += 1
# 	elsif x.suit == "club" && x.value == 8
# 		c8count += 1
# 	elsif x.suit == "club" && x.value == 9
# 		c9count += 1
# 	elsif x.suit == "club" && x.value == 10
# 		c10count += 1
# 	elsif x.suit == "club" && x.value == 11
# 		cJcount += 1
# 	elsif x.suit == "club" && x.value == 12
# 		cQcount += 1
# 	elsif x.suit == "club" && x.value == 13
# 		cKcount += 1
# 	elsif x.suit == "club" && x.value == 14
# 		cAcount += 1
# 	elsif x.suit == "spade" && x.value == 6
# 		s6count += 1
# 	elsif x.suit == "spade" && x.value == 7
# 		s7count += 1
# 	elsif x.suit == "spade" && x.value == 8
# 		s8count += 1
# 	elsif x.suit == "spade" && x.value == 9
# 		s9count += 1
# 	elsif x.suit == "spade" && x.value == 10
# 		s10count += 1
# 	elsif x.suit == "spade" && x.value == 11
# 		sJcount += 1
# 	elsif x.suit == "spade" && x.value == 12
# 		sQcount += 1
# 	elsif x.suit == "spade" && x.value == 13
# 		sKcount += 1
# 	elsif x.suit == "spade" && x.value == 14
# 		sAcount += 1
# 	elsif x.suit == "heart" && x.value == 6
# 		h6count += 1
# 	elsif x.suit == "heart" && x.value == 7
# 		h7count += 1
# 	elsif x.suit == "heart" && x.value == 8
# 		h8count += 1
# 	elsif x.suit == "heart" && x.value == 9
# 		h9count += 1
# 	elsif x.suit == "heart" && x.value == 10
# 		h10count += 1
# 	elsif x.suit == "heart" && x.value == 11
# 		hJcount += 1
# 	elsif x.suit == "heart" && x.value == 12
# 		hQcount += 1
# 	elsif x.suit == "heart" && x.value == 13
# 		hKcount += 1
# 	elsif x.suit == "heart" && x.value == 14
# 		hAcount += 1
# 	elsif x.suit == "dimond" && x.value == 6
# 		d6count += 1
# 	elsif x.suit == "dimond" && x.value == 7
# 		d7count += 1
# 	elsif x.suit == "dimond" && x.value == 8
# 		d8count += 1
# 	elsif x.suit == "dimond" && x.value == 9
# 		d9count += 1
# 	elsif x.suit == "dimond" && x.value == 10
# 		d10count += 1
# 	elsif x.suit == "dimond" && x.value == 11
# 		dJcount += 1
# 	elsif x.suit == "dimond" && x.value == 12
# 		dQcount += 1
# 	elsif x.suit == "dimond" && x.value == 13
# 		dKcount += 1
# 	elsif x.suit == "dimond" && x.value == 14
# 		dAcount += 1
# 	end 			
# }

# puts "c6 count = #{c6count}"
# puts "c7 count = #{c7count}"
# puts "c8 count = #{c8count}"
# puts "c9 count = #{c9count}"
# puts "c10 count = #{c10count}"
# puts "cJ count = #{cJcount}"
# puts "cQ count = #{cQcount}"
# puts "cK count = #{cKcount}"
# puts "cA count = #{cAcount}"
# puts " "
# puts "d6 count = #{d6count}"
# puts "d7 count = #{d7count}"
# puts "d8 count = #{d8count}"
# puts "d9 count = #{d9count}"
# puts "d10 count = #{d10count}"
# puts "dJ count = #{dJcount}"
# puts "dQ count = #{dQcount}"
# puts "dK count = #{dKcount}"
# puts "dA count = #{dAcount}"
# puts " "
# puts "s6 count = #{s6count}"
# puts "s7 count = #{s7count}"
# puts "s8 count = #{s8count}"
# puts "s9 count = #{s9count}"
# puts "s10 count = #{s10count}"
# puts "sJ count = #{sJcount}"
# puts "sQ count = #{sQcount}"
# puts "sK count = #{sKcount}"
# puts "sA count = #{sAcount}"
# puts " "
# puts "h6 count = #{h6count}"
# puts "h7 count = #{h7count}"
# puts "h8 count = #{h8count}"
# puts "h9 count = #{h9count}"
# puts "h10 count = #{h10count}"
# puts "hJ count = #{hJcount}"
# puts "hQ count = #{hQcount}"
# puts "hK count = #{hKcount}"
# puts "hA count = #{hAcount}"

#deck.each{|test|
	# puts "#{c6.line1} #{d6.line1} #{s6.line1} #{h6.line1}"
	# puts "#{c6.line2} #{d6.line2} #{s6.line2} #{h6.line2}"
	# puts "#{c6.line3} #{d6.line3} #{s6.line3} #{h6.line3}"
	# puts "#{c6.line4} #{d6.line4} #{s6.line4} #{h6.line4}"
	# puts "#{c6.line5} #{d6.line5} #{s6.line5} #{h6.line5}"
	# puts "#{c6.line6} #{d6.line6} #{s6.line6} #{h6.line6}"
	# puts "#{c6.line7} #{d6.line7} #{s6.line7} #{h6.line7}"

	# puts "#{c7.line1} #{d7.line1} #{s7.line1} #{h7.line1}"
	# puts "#{c7.line2} #{d7.line2} #{s7.line2} #{h7.line2}"
	# puts "#{c7.line3} #{d7.line3} #{s7.line3} #{h7.line3}"
	# puts "#{c7.line4} #{d7.line4} #{s7.line4} #{h7.line4}"
	# puts "#{c7.line5} #{d7.line5} #{s7.line5} #{h7.line5}"
	# puts "#{c7.line6} #{d7.line6} #{s7.line6} #{h7.line6}"
	# puts "#{c7.line7} #{d7.line7} #{s7.line7} #{h7.line7}"

	# puts "#{c8.line1} #{d8.line1} #{s8.line1} #{h8.line1}"
	# puts "#{c8.line2} #{d8.line2} #{s8.line2} #{h8.line2}"
	# puts "#{c8.line3} #{d8.line3} #{s8.line3} #{h8.line3}"
	# puts "#{c8.line4} #{d8.line4} #{s8.line4} #{h8.line4}"
	# puts "#{c8.line5} #{d8.line5} #{s8.line5} #{h8.line5}"
	# puts "#{c8.line6} #{d8.line6} #{s8.line6} #{h8.line6}"
	# puts "#{c8.line7} #{d8.line7} #{s8.line7} #{h8.line7}"

	# puts "#{c9.line1} #{d9.line1} #{s9.line1} #{h9.line1}"
	# puts "#{c9.line2} #{d9.line2} #{s9.line2} #{h9.line2}"
	# puts "#{c9.line3} #{d9.line3} #{s9.line3} #{h9.line3}"
	# puts "#{c9.line4} #{d9.line4} #{s9.line4} #{h9.line4}"
	# puts "#{c9.line5} #{d9.line5} #{s9.line5} #{h9.line5}"
	# puts "#{c9.line6} #{d9.line6} #{s9.line6} #{h9.line6}"
	# puts "#{c9.line7} #{d9.line7} #{s9.line7} #{h9.line7}"

	# puts "#{c10.line1} #{d10.line1} #{s10.line1} #{h10.line1}"
	# puts "#{c10.line2} #{d10.line2} #{s10.line2} #{h10.line2}"
	# puts "#{c10.line3} #{d10.line3} #{s10.line3} #{h10.line3}"
	# puts "#{c10.line4} #{d10.line4} #{s10.line4} #{h10.line4}"
	# puts "#{c10.line5} #{d10.line5} #{s10.line5} #{h10.line5}"
	# puts "#{c10.line6} #{d10.line6} #{s10.line6} #{h10.line6}"
	# puts "#{c10.line7} #{d10.line7} #{s10.line7} #{h10.line7}"

	# puts "#{cJ.line1} #{dJ.line1} #{sJ.line1} #{hJ.line1}"
	# puts "#{cJ.line2} #{dJ.line2} #{sJ.line2} #{hJ.line2}"
	# puts "#{cJ.line3} #{dJ.line3} #{sJ.line3} #{hJ.line3}"
	# puts "#{cJ.line4} #{dJ.line4} #{sJ.line4} #{hJ.line4}"
	# puts "#{cJ.line5} #{dJ.line5} #{sJ.line5} #{hJ.line5}"
	# puts "#{cJ.line6} #{dJ.line6} #{sJ.line6} #{hJ.line6}"
	# puts "#{cJ.line7} #{dJ.line7} #{sJ.line7} #{hJ.line7}"

	# puts "#{cQ.line1} #{dQ.line1} #{sQ.line1} #{hQ.line1}"
	# puts "#{cQ.line2} #{dQ.line2} #{sQ.line2} #{hQ.line2}"
	# puts "#{cQ.line3} #{dQ.line3} #{sQ.line3} #{hQ.line3}"
	# puts "#{cQ.line4} #{dQ.line4} #{sQ.line4} #{hQ.line4}"
	# puts "#{cQ.line5} #{dQ.line5} #{sQ.line5} #{hQ.line5}"
	# puts "#{cQ.line6} #{dQ.line6} #{sQ.line6} #{hQ.line6}"
	# puts "#{cQ.line7} #{dQ.line7} #{sQ.line7} #{hQ.line7}"

	# puts "#{cK.line1} #{dK.line1} #{sK.line1} #{hK.line1}"
	# puts "#{cK.line2} #{dK.line2} #{sK.line2} #{hK.line2}"
	# puts "#{cK.line3} #{dK.line3} #{sK.line3} #{hK.line3}"
	# puts "#{cK.line4} #{dK.line4} #{sK.line4} #{hK.line4}"
	# puts "#{cK.line5} #{dK.line5} #{sK.line5} #{hK.line5}"
	# puts "#{cK.line6} #{dK.line6} #{sK.line6} #{hK.line6}"
	# puts "#{cK.line7} #{dK.line7} #{sK.line7} #{hK.line7}"

	# puts "#{cA.line1} #{dA.line1} #{sA.line1} #{hA.line1}"
	# puts "#{cA.line2} #{dA.line2} #{sA.line2} #{hA.line2}"
	# puts "#{cA.line3} #{dA.line3} #{sA.line3} #{hA.line3}"
	# puts "#{cA.line4} #{dA.line4} #{sA.line4} #{hA.line4}"
	# puts "#{cA.line5} #{dA.line5} #{sA.line5} #{hA.line5}"
	# puts "#{cA.line6} #{dA.line6} #{sA.line6} #{hA.line6}"
	# puts "#{cA.line7} #{dA.line7} #{sA.line7} #{hA.line7}"
# def setup
# 		space = "  "
# 		puts "	#{@ohand[0].b_line1}  #{@ohand[1].b_line1}  #{@ohand[2].b_line1}  #{@ohand[3].b_line1}  #{@ohand[4].b_line1}  #{@ohand[5].b_line1}"
# 		puts "  #{@ohand[0].b_line2}  #{@ohand[1].b_line2}  #{@ohand[2].b_line2}  #{@ohand[3].b_line2}  #{@ohand[4].b_line2}  #{@ohand[5].b_line2}"
# 		puts "  #{@ohand[0].b_line3}  #{@ohand[1].b_line3}  #{@ohand[2].b_line3}  #{@ohand[3].b_line3}  #{@ohand[4].b_line3}  #{@ohand[5].b_line3}"
# 		puts "  #{@ohand[0].b_line4}  #{@ohand[1].b_line4}  #{@ohand[2].b_line4}  #{@ohand[3].b_line4}  #{@ohand[4].b_line4}  #{@ohand[5].b_line4}"
# 		puts "  #{@ohand[0].b_line5}  #{@ohand[1].b_line5}  #{@ohand[2].b_line5}  #{@ohand[3].b_line5}  #{@ohand[4].b_line5}  #{@ohand[5].b_line5}"
# 		puts "  #{@ohand[0].b_line6}  #{@ohand[1].b_line6}  #{@ohand[2].b_line6}  #{@ohand[3].b_line6}  #{@ohand[4].b_line6}  #{@ohand[5].b_line6}"
# 		puts "  #{@ohand[0].b_line7}  #{@ohand[1].b_line7}  #{@ohand[2].b_line7}  #{@ohand[3].b_line7}  #{@ohand[4].b_line7}  #{@ohand[5].b_line7}"
# 		puts " "
# 		puts " 											               	                        T R U M P"
# 		puts "                                             #{@deck[0].b_line1}  #{@deck[-1].line1}"
# 		puts "                                             #{@deck[0].b_line2}  #{@deck[-1].line2}"
# 		puts "                                             #{@deck[0].b_line3}  #{@deck[-1].line3}"
# 		puts "                                             #{@deck[0].b_line4}  #{@deck[-1].line4}"
# 		puts "                                             #{@deck[0].b_line5}  #{@deck[-1].line5}"
# 		puts "                                             #{@deck[0].b_line6}  #{@deck[-1].line6}"
# 		puts "                                             #{@deck[0].b_line7}  #{@deck[-1].line7}"
# 		puts " "
# 		puts " "
# 		puts "  #{@phand[0].line1}  #{@phand[1].line1}  #{@phand[2].line1}  #{@phand[3].line1}  #{@phand[4].line1}  #{@phand[5].line1}"
# 		puts "  #{@phand[0].line2}  #{@phand[1].line2}  #{@phand[2].line2}  #{@phand[3].line2}  #{@phand[4].line2}  #{@phand[5].line2}"
# 		puts "  #{@phand[0].line3}  #{@phand[1].line3}  #{@phand[2].line3}  #{@phand[3].line3}  #{@phand[4].line3}  #{@phand[5].line3}"
# 		puts "  #{@phand[0].line4}  #{@phand[1].line4}  #{@phand[2].line4}  #{@phand[3].line4}  #{@phand[4].line4}  #{@phand[5].line4}"
# 		puts "  #{@phand[0].line5}  #{@phand[1].line5}  #{@phand[2].line5}  #{@phand[3].line5}  #{@phand[4].line5}  #{@phand[5].line5}"
# 		puts "  #{@phand[0].line6}  #{@phand[1].line6}  #{@phand[2].line6}  #{@phand[3].line6}  #{@phand[4].line6}  #{@phand[5].line6}"
# 		puts "  #{@phand[0].line7}  #{@phand[1].line7}  #{@phand[2].line7}  #{@phand[3].line7}  #{@phand[4].line7}  #{@phand[5].line7}"
# 		turn()
# 	end

# c6count = 0
# c7count = 0
# c8count = 0
# c9count = 0
# c10count = 0
# cJcount = 0
# cQcount = 0
# cKcount = 0
# cAcount = 0

# d6count = 0
# d7count = 0
# d8count = 0
# d9count = 0
# d10count = 0
# dJcount = 0
# dQcount = 0
# dKcount = 0
# dAcount = 0

# h6count = 0
# h7count = 0
# h8count = 0
# h9count = 0
# h10count = 0
# hJcount = 0
# hQcount = 0
# hKcount = 0
# hAcount = 0

# s6count = 0
# s7count = 0
# s8count = 0
# s9count = 0
# s10count = 0
# sJcount = 0
# sQcount = 0
# sKcount = 0
# sAcount = 0

# @deck.each{|x|
# 	if x.suit == "club" && x.value == 6
# 		c6count += 1
# 	elsif x.suit == "club" && x.value == 7
# 		c7count += 1
# 	elsif x.suit == "club" && x.value == 8
# 		c8count += 1
# 	elsif x.suit == "club" && x.value == 9
# 		c9count += 1
# 	elsif x.suit == "club" && x.value == 10
# 		c10count += 1
# 	elsif x.suit == "club" && x.value == 11
# 		cJcount += 1
# 	elsif x.suit == "club" && x.value == 12
# 		cQcount += 1
# 	elsif x.suit == "club" && x.value == 13
# 		cKcount += 1
# 	elsif x.suit == "club" && x.value == 14
# 		cAcount += 1
# 	elsif x.suit == "spade" && x.value == 6
# 		s6count += 1
# 	elsif x.suit == "spade" && x.value == 7
# 		s7count += 1
# 	elsif x.suit == "spade" && x.value == 8
# 		s8count += 1
# 	elsif x.suit == "spade" && x.value == 9
# 		s9count += 1
# 	elsif x.suit == "spade" && x.value == 10
# 		s10count += 1
# 	elsif x.suit == "spade" && x.value == 11
# 		sJcount += 1
# 	elsif x.suit == "spade" && x.value == 12
# 		sQcount += 1
# 	elsif x.suit == "spade" && x.value == 13
# 		sKcount += 1
# 	elsif x.suit == "spade" && x.value == 14
# 		sAcount += 1
# 	elsif x.suit == "heart" && x.value == 6
# 		h6count += 1
# 	elsif x.suit == "heart" && x.value == 7
# 		h7count += 1
# 	elsif x.suit == "heart" && x.value == 8
# 		h8count += 1
# 	elsif x.suit == "heart" && x.value == 9
# 		h9count += 1
# 	elsif x.suit == "heart" && x.value == 10
# 		h10count += 1
# 	elsif x.suit == "heart" && x.value == 11
# 		hJcount += 1
# 	elsif x.suit == "heart" && x.value == 12
# 		hQcount += 1
# 	elsif x.suit == "heart" && x.value == 13
# 		hKcount += 1
# 	elsif x.suit == "heart" && x.value == 14
# 		hAcount += 1
# 	elsif x.suit == "diamond" && x.value == 6
# 		d6count += 1
# 	elsif x.suit == "diamond" && x.value == 7
# 		d7count += 1
# 	elsif x.suit == "diamond" && x.value == 8
# 		d8count += 1
# 	elsif x.suit == "diamond" && x.value == 9
# 		d9count += 1
# 	elsif x.suit == "diamond" && x.value == 10
# 		d10count += 1
# 	elsif x.suit == "diamond" && x.value == 11
# 		dJcount += 1
# 	elsif x.suit == "diamond" && x.value == 12
# 		dQcount += 1
# 	elsif x.suit == "diamond" && x.value == 13
# 		dKcount += 1
# 	elsif x.suit == "diamond" && x.value == 14
# 		dAcount += 1
# 	end }

# 	puts "c6 count = #{c6count}"
# puts "c7 count = #{c7count}"
# puts "c8 count = #{c8count}"
# puts "c9 count = #{c9count}"
# puts "c10 count = #{c10count}"
# puts "cJ count = #{cJcount}"
# puts "cQ count = #{cQcount}"
# puts "cK count = #{cKcount}"
# puts "cA count = #{cAcount}"
# puts " "
# puts "d6 count = #{d6count}"
# puts "d7 count = #{d7count}"
# puts "d8 count = #{d8count}"
# puts "d9 count = #{d9count}"
# puts "d10 count = #{d10count}"
# puts "dJ count = #{dJcount}"
# puts "dQ count = #{dQcount}"
# puts "dK count = #{dKcount}"
# puts "dA count = #{dAcount}"
# puts " "
# puts "s6 count = #{s6count}"
# puts "s7 count = #{s7count}"
# puts "s8 count = #{s8count}"
# puts "s9 count = #{s9count}"
# puts "s10 count = #{s10count}"
# puts "sJ count = #{sJcount}"
# puts "sQ count = #{sQcount}"
# puts "sK count = #{sKcount}"
# puts "sA count = #{sAcount}"
# puts " "
# puts "h6 count = #{h6count}"
# puts "h7 count = #{h7count}"
# puts "h8 count = #{h8count}"
# puts "h9 count = #{h9count}"
# puts "h10 count = #{h10count}"
# puts "hJ count = #{hJcount}"
# puts "hQ count = #{hQcount}"
# puts "hK count = #{hKcount}"
# puts "hA count = #{hAcount}"			

# puts "#{@deck[0].line1} #{@deck[1].line1} #{@deck[2].line1} #{@deck[3].line1}"
# puts "#{@deck[0].line2} #{@deck[1].line2} #{@deck[2].line2} #{@deck[3].line2}"
# puts "#{@deck[0].line3} #{@deck[1].line3} #{@deck[2].line3} #{@deck[3].line3}"
# puts "#{@deck[0].line4} #{@deck[1].line4} #{@deck[2].line4} #{@deck[3].line4}"
# puts "#{@deck[0].line5} #{@deck[1].line5} #{@deck[2].line5} #{@deck[3].line5}"
# puts "#{@deck[0].line6} #{@deck[1].line6} #{@deck[2].line6} #{@deck[3].line6}"
# puts "#{@deck[0].line7} #{@deck[1].line7} #{@deck[2].line7} #{@deck[3].line7}"

# puts "#{@deck[4].line1} #{@deck[5].line1} #{@deck[6].line1} #{@deck[7].line1}"
# puts "#{@deck[4].line2} #{@deck[5].line2} #{@deck[6].line2} #{@deck[7].line2}"
# puts "#{@deck[4].line3} #{@deck[5].line3} #{@deck[6].line3} #{@deck[7].line3}"
# puts "#{@deck[4].line4} #{@deck[5].line4} #{@deck[6].line4} #{@deck[7].line4}"
# puts "#{@deck[4].line5} #{@deck[5].line5} #{@deck[6].line5} #{@deck[7].line5}"
# puts "#{@deck[4].line6} #{@deck[5].line6} #{@deck[6].line6} #{@deck[7].line6}"
# puts "#{@deck[4].line7} #{@deck[5].line7} #{@deck[6].line7} #{@deck[7].line7}"

# puts "#{@deck[8].line1} #{@deck[9].line1} #{@deck[10].line1} #{@deck[11].line1}"
# puts "#{@deck[8].line2} #{@deck[9].line2} #{@deck[10].line2} #{@deck[11].line2}"
# puts "#{@deck[8].line3} #{@deck[9].line3} #{@deck[10].line3} #{@deck[11].line3}"
# puts "#{@deck[8].line4} #{@deck[9].line4} #{@deck[10].line4} #{@deck[11].line4}"
# puts "#{@deck[8].line5} #{@deck[9].line5} #{@deck[10].line5} #{@deck[11].line5}"
# puts "#{@deck[8].line6} #{@deck[9].line6} #{@deck[10].line6} #{@deck[11].line6}"
# puts "#{@deck[8].line7} #{@deck[9].line7} #{@deck[10].line7} #{@deck[11].line7}"

# puts "#{@deck[12].line1} #{@deck[13].line1} #{@deck[14].line1} #{@deck[15].line1}"
# puts "#{@deck[12].line2} #{@deck[13].line2} #{@deck[14].line2} #{@deck[15].line2}"
# puts "#{@deck[12].line3} #{@deck[13].line3} #{@deck[14].line3} #{@deck[15].line3}"
# puts "#{@deck[12].line4} #{@deck[13].line4} #{@deck[14].line4} #{@deck[15].line4}"
# puts "#{@deck[12].line5} #{@deck[13].line5} #{@deck[14].line5} #{@deck[15].line5}"
# puts "#{@deck[12].line6} #{@deck[13].line6} #{@deck[14].line6} #{@deck[15].line6}"
# puts "#{@deck[12].line7} #{@deck[13].line7} #{@deck[14].line7} #{@deck[15].line7}"

# puts "#{@deck[16].line1} #{@deck[17].line1} #{@deck[18].line1} #{@deck[19].line1}"
# puts "#{@deck[16].line2} #{@deck[17].line2} #{@deck[18].line2} #{@deck[19].line2}"
# puts "#{@deck[16].line3} #{@deck[17].line3} #{@deck[18].line3} #{@deck[19].line3}"
# puts "#{@deck[16].line4} #{@deck[17].line4} #{@deck[18].line4} #{@deck[19].line4}"
# puts "#{@deck[16].line5} #{@deck[17].line5} #{@deck[18].line5} #{@deck[19].line5}"
# puts "#{@deck[16].line6} #{@deck[17].line6} #{@deck[18].line6} #{@deck[19].line6}"
# puts "#{@deck[16].line7} #{@deck[17].line7} #{@deck[18].line7} #{@deck[19].line7}"

# puts "#{@deck[20].line1} #{@deck[21].line1} #{@deck[22].line1} #{@deck[23].line1}"
# puts "#{@deck[20].line2} #{@deck[21].line2} #{@deck[22].line2} #{@deck[23].line2}"
# puts "#{@deck[20].line3} #{@deck[21].line3} #{@deck[22].line3} #{@deck[23].line3}"
# puts "#{@deck[20].line4} #{@deck[21].line4} #{@deck[22].line4} #{@deck[23].line4}"
# puts "#{@deck[20].line5} #{@deck[21].line5} #{@deck[22].line5} #{@deck[23].line5}"
# puts "#{@deck[20].line6} #{@deck[21].line6} #{@deck[22].line6} #{@deck[23].line6}"
# puts "#{@deck[20].line7} #{@deck[21].line7} #{@deck[22].line7} #{@deck[23].line7}"

# puts "#{@deck[24].line1} #{@deck[25].line1} #{@deck[26].line1} #{@deck[27].line1}"
# puts "#{@deck[24].line2} #{@deck[25].line2} #{@deck[26].line2} #{@deck[27].line2}"
# puts "#{@deck[24].line3} #{@deck[25].line3} #{@deck[26].line3} #{@deck[27].line3}"
# puts "#{@deck[24].line4} #{@deck[25].line4} #{@deck[26].line4} #{@deck[27].line4}"
# puts "#{@deck[24].line5} #{@deck[25].line5} #{@deck[26].line5} #{@deck[27].line5}"
# puts "#{@deck[24].line6} #{@deck[25].line6} #{@deck[26].line6} #{@deck[27].line6}"
# puts "#{@deck[24].line7} #{@deck[25].line7} #{@deck[26].line7} #{@deck[27].line7}"

# puts "#{@deck[28].line1} #{@deck[29].line1} #{@deck[30].line1} #{@deck[31].line1}"
# puts "#{@deck[28].line2} #{@deck[29].line2} #{@deck[30].line2} #{@deck[31].line2}"
# puts "#{@deck[28].line3} #{@deck[29].line3} #{@deck[30].line3} #{@deck[31].line3}"
# puts "#{@deck[28].line4} #{@deck[29].line4} #{@deck[30].line4} #{@deck[31].line4}"
# puts "#{@deck[28].line5} #{@deck[29].line5} #{@deck[30].line5} #{@deck[31].line5}"
# puts "#{@deck[28].line6} #{@deck[29].line6} #{@deck[30].line6} #{@deck[31].line6}"
# puts "#{@deck[28].line7} #{@deck[29].line7} #{@deck[30].line7} #{@deck[31].line7}"

# puts "#{@deck[32].line1} #{@deck[33].line1} #{@deck[34].line1} #{@deck[35].line1}"
# puts "#{@deck[32].line2} #{@deck[33].line2} #{@deck[34].line2} #{@deck[35].line2}"
# puts "#{@deck[32].line3} #{@deck[33].line3} #{@deck[34].line3} #{@deck[35].line3}"
# puts "#{@deck[32].line4} #{@deck[33].line4} #{@deck[34].line4} #{@deck[35].line4}"
# puts "#{@deck[32].line5} #{@deck[33].line5} #{@deck[34].line5} #{@deck[35].line5}"
# puts "#{@deck[32].line6} #{@deck[33].line6} #{@deck[34].line6} #{@deck[35].line6}"
# puts "#{@deck[32].line7} #{@deck[33].line7} #{@deck[34].line7} #{@deck[35].line7}"