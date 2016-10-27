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

		@attack = [] #set holder for attacing cards
		@defend = [] #set holder for defending cards

		shuffle() #randomly order deck array
	end

	def shuffle #randomly order deck array
		@deck.length.times do |x| #get location of cards in order
			location = rand(@deck.length) #get place of random card
			temp = @deck[location] #hold random card
			@deck[location] = @deck[x] #put random card in current location
			@deck[x] = temp #put card from current location in random location
		end

		deal() #fill player and opponent arrays
	end

	def deal
		6.times do #give each player 6 cards from the top of the deck
			@phand << @deck.shift #put next card in player hand
			@ohand << @deck.shift #put next card in opponent hand
		end

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

		@phand.each do |x|
			if x.suit == "club" #identify clubs
				club_ary << x #put all clubs into club array
			elsif x.suit == "diamond" #identify diamonds
				diamond_ary << x #put all diamonds into diamond array
			elsif x.suit == "heart" #identify hearts
				heart_ary << x #put all hearts into heart array
			elsif x.suit == "spade" #identify spades
				spade_ary << x #put all spades into spade array
			end
		end

		club_ary = club_ary.sort_by{|x| x.value}.reverse #sort clubs by card value
		diamond_ary = diamond_ary.sort_by{|x| x.value}.reverse #sort diamonds by card value
		heart_ary = heart_ary.sort_by{|x| x.value}.reverse #sort hearts by card value
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
		oline1 = oline2 = oline3 = oline4 = oline5 = oline6 = oline7 = "" #initialize strings that will show opponent cards

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
		ocards() #show opponents hand
		inplay0 = inplay1 = inplay2 = inplay3 = inplay4 = inplay5 = inplay6 = inplay7 = inplay8 = inplay9 ="        " #initialize lines for cards in play
		spaces = "           "
		@attack.count.times do |x|
			inplay0 += "  #{@attack[x].line1}" #make a string of attacking cards in play
			inplay1 += "  #{@attack[x].line2}"
			inplay2 += "  #{@attack[x].line3}"

			inplay3 += (@defend.count >= x && @defend[x] != nil) ? "  #{@defend[x].line1}" :"  #{@attack[x].line4}"
			inplay4 += (@defend.count >= x && @defend[x] != nil) ? "  #{@defend[x].line2}" : "  #{@attack[x].line5}"
			inplay5 += (@defend.count >= x && @defend[x] != nil) ? "  #{@defend[x].line3}" : "  #{@attack[x].line6}"
			inplay6 += (@defend.count >= x && @defend[x] != nil) ? "  #{@defend[x].line4}" : "  #{@attack[x].line7}"
			inplay7 += (@defend.count >= x && @defend[x] != nil) ? "  #{@defend[x].line5}" : spaces
			inplay8 += (@defend.count >= x && @defend[x] != nil) ? "  #{@defend[x].line6}" : spaces
			inplay9 += (@defend.count >= x && @defend[x] != nil) ? "  #{@defend[x].line7}" : spaces
		end

		if @attack.count == 0
			spaces = "                              "
		elsif @attack.count == 1
			spaces = "                   "
		elsif @attack.count == 2
			spaces = "        "
		else
			spaces = "    "
		end

		if @deck.count > 0
			inplay0 += "#{spaces}           T R U M P"
			inplay1 += "#{spaces}#{@deck[0].b_line1}  #{@deck[-1].line1}" #show bottom card as trump
			inplay2 += "#{spaces}#{@deck[0].b_line2}  #{@deck[-1].line2}"
			inplay3 += "#{spaces}#{@deck[0].b_line3}  #{@deck[-1].line3}"
			inplay4 += "#{spaces}#{@deck[0].b_line4}  #{@deck[-1].line4}"
			inplay5 += "#{spaces}#{@deck[0].b_line5}  #{@deck[-1].line5}"
			inplay6 += "#{spaces}#{@deck[0].b_line6}  #{@deck[-1].line6}"
			inplay7 += "#{spaces}#{@deck[0].b_line7}  #{@deck[-1].line7}"
			inplay8 += "#{spaces}    #{@deck.count}" #shows cards remaining in deck
		else
			inplay0 += "#{spaces}           T R U M P"
			if @trump.suit == "heart"
				inplay1 += "#{spaces}               ♥"
			elsif @trump.suit == "spade"
				inplay1 += "#{spaces}               ♠"
			elsif @trump.suit == "diamond"
				inplay1 += "#{spaces}               ♦"
			elsif @trump.suit == "club"
				inplay1 += "#{spaces}               ♣"
			end
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

		pcards() #show players hand

		end_game() if @phand.count == 0 || @ohand.count == 0
	end

	def pcards
		pline1 = pline2 = pline3 = pline4 = pline5 = pline6 = pline7 = pline8 = "" #initialize strings that will show player cards
		pcount = 0 # counts playable cards
		#create player strings
		@phand.count.times do |x|
			#playable cards shown higher than others
			pline1 += (@phand[x].canplay) ? "  #{@phand[x].line1}" : "           "
			#unplayable cards shown at regular height
			pline2 += (@phand[x].canplay) ? "  #{@phand[x].line2}" : "  #{@phand[x].line1}"
			end}
		@phand.count.times{|x|
			if @phand[x].canplay
				pline3 += "  #{@phand[x].line3}" #unplayable cards shown at regular height
			else
				pline3 += "  #{@phand[x].line2}"
			end}
		@phand.count.times{|x|
			if @phand[x].canplay
				pline4 += "  #{@phand[x].line4}" #unplayable cards shown at regular height
			else
				pline4 += "  #{@phand[x].line3}"
			end}
		@phand.count.times{|x|
			if @phand[x].canplay
				pline5 += "  #{@phand[x].line5}" #unplayable cards shown at regular height
			else
				pline5 += "  #{@phand[x].line4}"
			end}
		@phand.count.times{|x|
			if @phand[x].canplay
				pline6 += "  #{@phand[x].line6}" #unplayable cards shown at regular height
			else
				pline6 += "  #{@phand[x].line5}"
			end}
		@phand.count.times{|x|
			if @phand[x].canplay
				pline7 += "  #{@phand[x].line7}" #unplayable cards shown at regular height
			else
				pline7 += "  #{@phand[x].line6}"
			end}
		@phand.count.times{|x|
			if @phand[x].canplay
				pcount += 1
					pline8 += "      #{pcount}    "
			else
				pline8 += "  #{@phand[x].line7}"
			end}

		#puts "\n" #if card can be played shift it up 1 row
		puts "#{pline1}" #display player cards face up
		puts "#{pline2}"
		puts "#{pline3}"
		puts "#{pline4}"
		puts "#{pline5}"
		puts "#{pline6}"
		puts "#{pline7}"
		puts "#{pline8}"
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
		setup()
		launch_atk()
	end

	def end_game
		if @phand.count == 0
			abort("Congratulations!! You Won!!")
		elsif @ohand.count == 0
			abort("Oh No! You are the DURAK!")
		end
		puts "Reach out at kenikall@gmail.com to let me know what you think."
		puts "Follow me on Twitter: @MannahKallon"
		exit
	end

#TURN LOGIC
	def launch_atk #attacker plays card
		if @phand.count == 0 || @ohand.count == 0
			end_game()
		end

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
		mount_def()
	end

	def mount_def() #defend, take or transfer (on initial attack)
		if @attacker == "player"
			transfer = nil
			if @defend.count == 0 #can only defend if there has been no defense
				@ohand.each{|x| #look to transfer
					if @attack[-1].value == x.value
						@phand.delete(x) #remove card from oponent hand
						transfer = x #hold transfer card
					end}

				if transfer != nil
					@attacker = "opponent" #make opponent attacker
					@attack << transfer
					@ohand.delete(transfer)
					setup() #show game space
					@attacker = "opponent"
					puts "The opponent transfered the attack. You must now defend."
					def_transfer()
				end
			end

			@ohand.each{|x| #look to defend

				if (@attack[-1].value < x.value && @attack[-1].suit == x.suit)||(@attack[-1].suit != @trump.suit && x. suit == @trump.suit)
					@ohand.delete(x) #remove card from oponent hand
					@defend << x # put card in play
					setup() #show game space
					puts "The opponent defends with the #{x.name}."
					throwing_in()
				end}
			@ohand += @attack #give player all attacking cards
			@ohand += @defend #give player all defending cards
			@attack = [] #remove all attacking cards
			@defend = [] #remove all defending cards
			@attacker = "player" #switch attacker
			setup() #show game space
			puts "The opponent takes."
			end_turn() #player attacks
		else
			cantransfer = false #only let players transfer under certian conditions
			playable() #identify all playable cards in players hand
			setup()
			choices = [] #array for playable cards
			@phand.each{|x| #fill array with playable cards
				if x.canplay
					choices << x
				end}

			if @defend.count == 0 #can only transfer on initial attack
				@phand.each{|x|
					if x.value == @attack[0].value
						cantransfer = true
					end
					}
			end
			num = @attack[0].name.split #get the name of the attacking card
				num = num[0].to_s #only get the first part of the name
			if cantransfer
				puts "TRANSFER attack with a #{num}."
			end
			puts "DEFEND with a #{@trump.suit} to trump, or a #{@attack[-1].suit} higher than the #{num}"
			puts "Select #{choices.count + 1} to TAKE"

			#GET USER INPUT
			validinput = false #verify input
			until validinput
				card = gets.chomp.to_i

				if card.class != Fixnum || card > choices.count+1 || card < 0 #define valid input
					puts "Please choose a card with #{(1..choices.count).to_a.join(", ")}, or #{choices.count + 1} to TAKE."#give player feedback
				else
					validinput = true
				end
			end

			@phand.each{|x| x.canplay = false} #reset all cards to unplayable

			if card > choices.count #player takes all cards
				@phand += @attack #give player all attacking cards
				@phand += @defend #give player all defending cards
				@attack = [] #remove all attacking cards
				@defend = [] #remove all defending cards
				@attacker = "opponent" #switch attacker
				order() #organize player cards
				setup() #show game space
				puts "All of the cards in play were added to your hand."
				end_turn()
			elsif choices[card-1].value == @attack[-1].value && @defend.count == 0
				@attack << choices[card-1] # put card in play
				@attacker = "player" #make player attacker
				@phand.delete(choices[card-1]) #remove card from player hand
				setup() #show game space
				puts "You transfered to your opponent."
				def_transfer()
			else
				@defend << choices[card-1] #cover attacking card with defending card
				@phand.delete(choices[card-1]) #remove card from player hand
				setup() #show game space
				puts "You defended with a #{choices[card-1].name}."
				throwing_in()
			end
		end
#D 1. Take all cards in play get added to defender's hand #attacker stays attacker
#D 2. Defender plays a trump or higher card of attacking card's suit #attacker can throw in
#D 3. Defender throws card with same value as attack. #Defender becomes attacker
	end

	def throwing_in
		if @attacker == "player" #reset playable cards
			@phand.each{|x|
				@attack.each{|y|
					if x.value == y.value
						x.canplay = true
					end
				@defend.each{|z|
					if x.value == z.value
						x.canplay = true
					end}}}

			choices = [] #array for playable cards
			@phand.each{|x| #fill array with playable cards
				if x.canplay
					choices << x
				end}
			setup() #show game space

			if choices.length > 0
				puts "Continue the attack by matching the value of a card in play."
			end
			puts "Select #{choices.count + 1} to end the turn."

			#GET USER INPUT
			validinput = false #verify input
			until validinput
				card = gets.chomp.to_i

				if card.class != Fixnum || card > choices.count+1 || card < 0 #define valid input
					puts "Please choose a card with #{(1..choices.count).to_a.join(", ")}, or #{choices.count + 1} to end the turn."#give player feedback
				else
					validinput = true
				end
			end

			if card == choices.count+1
				@attacker = "opponent"
				end_turn()
			else
				@attack << choices[card-1] #put attacking card in attacking array
			    @phand.delete(@attack[-1]) #remove card from player hand
			    mount_def()
			end
		else
			@ohand.each{|x|
				@attack.each{|y|
					if x.value == y.value
						@attack << x
						@ohand.delete(x)
						puts "Your opponent throws in a #{x.name}"
						mount_def()
					end}
				@defend.each{|z|
					if x.value == z.value
						@attack << x
						@ohand.delete(x)
						puts "Your opponent throws in a #{x.name}"
						mount_def()
					end}}
			puts "You opponent discards the cards in play."
			@attacker = "player"
			end_turn()
		end
	end

	def def_transfer

		if @attacker == "player"
			@attack.each{|transattack|
					@ohand.each{|x| #go through opponent hand
					if transattack.suit == @trump.suit && x.suit == @trump.suit && x.value > transattack.value
						@defend << x #put def card in defending array
				    	@ohand.delete(x) #remove card from player hand
					elsif x.suit == @trump.suit && transattack.suit != @trump.suit #player can always trump any non trump
						@defend << x #put def card in defending array
				    	@ohand.delete(x) #remove card from player hand
					elsif x.suit == transattack.suit && x.value > transattack.value #player can play a higher card of the same suit
						@defend << x #put def card in defending array
				    	@ohand.delete(x) #remove card from player hand
					end}}
			if @attack.count == @defend.count
				throwing_in()
			else
				puts "Your opponent can't play and takes the cards."
				@ohand += @attack
				@ohand += @defend
				end_turn()
			end
		else
			@attack.each{|transattack|
				@phand.each{|x| x.canplay = false} #reset all cards to unplayable
				@phand.each{|x| #go through player hand
					if transattack.suit == @trump.suit && x.suit == @trump.suit && x.value > transattack.value
						x.canplay = true
					elsif x.suit == @trump.suit && transattack.suit != @trump.suit #player can always trump any non trump
						x.canplay = true
					elsif x.suit == transattack.suit && x.value > transattack.value #player can play a higher card of the same suit
						x.canplay = true
					end}
				choices = [] #array for playable cards
				@phand.each{|x| #fill array with playable cards
					if x.canplay
						choices << x
					end}
				setup() #show game space
				puts "You can defend the #{transattack.name} or push #{choices.count+1} to take"
				validinput = false #verify input
				until validinput
					card = gets.chomp.to_i

					if card.class != Fixnum || card > choices.count+1 || card < 0 #define valid input
						puts "Please choose a card with #{(1..choices.count).to_a.join(", ")}, or #{choices.count + 1} to end the turn."#give player feedback
					else
						validinput = true
					end
				end

				if card == choices.count+1
					@phand += @attack
					@phand += @defend
					end_turn()
				else
					@defend << choices[card-1] #put def card in defending array
				    @phand.delete(choices[card-1]) #remove card from player hand
				end}
			throwing_in()
		end
	end

	def end_turn
		@phand.each{|x| x.canplay = false} #reset all cards to unplayable
		@attack = [] #clear cards in play
		@defend = []
		until (@phand.count >= 6 && @ohand.count >=6) || @deck.count <=0
			if @phand.count < 6
				@phand << @deck.shift
			end

			if @ohand.count < 6
				@ohand << @deck.shift
			end
		end
		order()
		setup()
		launch_atk()
	end

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

	def playable
		@phand.each{|x| #go through player hand
			if @attack[-1].suit == @trump.suit && x.suit == @trump.suit && x.value > @attack[-1].value
				x.canplay = true
			elsif x.suit == @trump.suit && @attack[-1].suit != @trump.suit #player can always trump any non trump
				x.canplay = true
			elsif x.suit == @attack[-1].suit && x.value > @attack[-1].value #player can play a higher card of the same suit
				x.canplay = true
			elsif x.value == @attack[-1].value && @defend.count == 0
				x.canplay = true
			else
				x.canplay = false
			end}
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
