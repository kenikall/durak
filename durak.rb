class Card
	attr_reader :suit, :value, :b_line1, :b_line2, 
	:b_line3, :b_line4, :b_line5, :b_line6, :b_line7,
	:line1, :line2, :line3, :line4, :line5, :line6, :line7

	def initialize(suit, value, line2, line3, line4, line5, line6)
		@suit = suit
		@value = value

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
		@deck = create_deck
		@phand =[]
		@ohand =[]
		@first = true
		shuffle()
		@attack = nil
		# @attack2 = nil
		# @attack3 = nil
		# @attack4 = nil
		@defend = nil
		# @defend1 = nil
		# @defend1 = nil
		# @defend1 = nil
	end
	
	def shuffle
		@deck.length.times{|x|
			location = rand(@deck.length)
			temp = @deck[location]
			@deck[location] = @deck[x]
			@deck[x] = temp
		}

		deal()
	#return deck
	end
	
	def deal
		6.times{
			@phand << @deck.shift
			@ohand << @deck.shift
		}
		setup()
	end

	def setup
		oline1 = oline2 = oline3 = oline4 = oline5 = oline6 = oline7 = ""
		pline1 = pline2 = pline3 = pline4 = pline5 = pline6 = pline7 = ""
		
		@ohand.count.times{|x| oline1 += "  #{@ohand[x].b_line1}"}
		@ohand.count.times{|x| oline2 += "  #{@ohand[x].b_line2}"}
		@ohand.count.times{|x| oline3 += "  #{@ohand[x].b_line3}"}
		@ohand.count.times{|x| oline4 += "  #{@ohand[x].b_line4}"}
		@ohand.count.times{|x| oline5 += "  #{@ohand[x].b_line5}"}
		@ohand.count.times{|x| oline6 += "  #{@ohand[x].b_line6}"}
		@ohand.count.times{|x| oline7 += "  #{@ohand[x].b_line7}"}
		
		puts "#{oline1}"
		puts "#{oline2}"
		puts "#{oline3}"
		puts "#{oline4}"
		puts "#{oline5}"
		puts "#{oline6}"
		puts "#{oline7}"

		if @attack == nil
			puts "\n"
			puts "                                                        T R U M P"
			puts "                                             #{@deck[0].b_line1}  #{@deck[-1].line1}"
			puts "                                             #{@deck[0].b_line2}  #{@deck[-1].line2}"
			puts "                                             #{@deck[0].b_line3}  #{@deck[-1].line3}"
			puts "                                             #{@deck[0].b_line4}  #{@deck[-1].line4}"
			puts "                                             #{@deck[0].b_line5}  #{@deck[-1].line5}"
			puts "                                             #{@deck[0].b_line6}  #{@deck[-1].line6}"
			puts "                                             #{@deck[0].b_line7}  #{@deck[-1].line7}"
			puts "\n"
			puts "\n"
		elsif @defend == nil
			puts "\n"
			puts "                 #{@attack.line1}                              T R U M P"
			puts "                 #{@attack.line2}                   #{@deck[0].b_line1}  #{@deck[-1].line1}"
			puts "                 #{@attack.line3}                   #{@deck[0].b_line2}  #{@deck[-1].line2}"
			puts "                 #{@attack.line4}                   #{@deck[0].b_line3}  #{@deck[-1].line3}"
			puts "                 #{@attack.line5}                   #{@deck[0].b_line4}  #{@deck[-1].line4}"
			puts "                 #{@attack.line6}                   #{@deck[0].b_line5}  #{@deck[-1].line5}"
			puts "                 #{@attack.line7}                   #{@deck[0].b_line6}  #{@deck[-1].line6}"
			puts "                                             #{@deck[0].b_line7}  #{@deck[-1].line7}"
			puts "\n"
			puts "\n"
		else
			puts "\n"
			puts "                 #{@attack.line1}                              T R U M P"
			puts "                 #{@attack.line2}                   #{@deck[0].b_line1}  #{@deck[-1].line1}"
			puts "                 #{@attack.line3}                   #{@deck[0].b_line2}  #{@deck[-1].line2}"
			puts "                 #{@defend.line1}                   #{@deck[0].b_line3}  #{@deck[-1].line3}"
			puts "                 #{@defend.line2}                   #{@deck[0].b_line4}  #{@deck[-1].line4}"
			puts "                 #{@defend.line3}                   #{@deck[0].b_line5}  #{@deck[-1].line5}"
			puts "                 #{@defend.line4}                   #{@deck[0].b_line6}  #{@deck[-1].line6}"
			puts "                 #{@defend.line5}                   #{@deck[0].b_line7}  #{@deck[-1].line7}"
			puts "                 #{@defend.line6}"
			puts "                 #{@defend.line7}"
		end

		@phand.count.times{|x| pline1 += "  #{@phand[x].line1}"}
		@phand.count.times{|x| pline2 += "  #{@phand[x].line2}"}
		@phand.count.times{|x| pline3 += "  #{@phand[x].line3}"}
		@phand.count.times{|x| pline4 += "  #{@phand[x].line4}"}
		@phand.count.times{|x| pline5 += "  #{@phand[x].line5}"}
		@phand.count.times{|x| pline6 += "  #{@phand[x].line6}"}
		@phand.count.times{|x| pline7 += "  #{@phand[x].line7}"}
		
		puts "#{pline1}"
		puts "#{pline2}"
		puts "#{pline3}"
		puts "#{pline4}"
		puts "#{pline5}"
		puts "#{pline6}"
		puts "#{pline7}"
		turn()
	end

	def turn
		if @first 
			ptrump = 20
			otrump = 20
			@trump = @deck[-1]
			
			@ohand.each{|x|
				if x.suit == @trump.suit
					if x.value < otrump
						otrump = x.value
					end
				end}

			@phand.each{|x|
				if x.suit == @trump.suit
					if x.value < ptrump
						ptrump = x.value
					end
				end}
			if ptrump < otrump
				puts "      1          2          3          4          5          6 "
				puts "Player is attacker. Which card would you like to play?"
				@turn = "player"
			else
				puts " "
				puts "Opponent is attacker. Opponent plays #{"opponent's card"}"
				@turn = "opponent"
				opponentmove()
			end
			@first = false
		end
	end

	def playermove(card)
		if @turn == "player"
			card -= 1
			@attack = @phand[card] 
			@phand.delete_at(card)
		else
			@defend = @phand[card]
			@phand.delete_at(card)
		end
		setup()
		opponentmove()
	end

	def opponentmove
		otrump = 20
		if @turn == "player"
			@defend = nil
			@ohand.each{|x|
				if x.suit == @attack.suit
					if x.value > @attack.value
						@defend = x
						card = x
					end
				end}
			if @defend == nil
				@ohand.each{|x|
				if x.suit == @trump.suit
					if x.value < otrump
						@defend = x
					end
				end}
			end

			if @defend == nil
				puts "The opponent takes."
			else 
			 	@ohand.delete(@defend)
			end
		else
			num = 20
			@ohand.each{|x| 
				if x.suit != @trump.suit
					if x.value < num
						@attack = x
					end
				end}
			@ohand.delete(@attack)
		end
		setup()
		puts "Opponent is attacking, chose your defense."
		card=gets.chomp.to_i
		playermove(card)
	end
end

def create_deck
	deck = []
	s6 = Card.new(
		"spade",
		6,
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
		"║A♥     ║",
		"║       ║",
		"║   ♥   ║",
	    "║       ║",
		"║     ♥A║"
		)
	deck << hA
	d6 = Card.new(
		"dimond",
		6,
		"║6      ║",
		"║ ♦   ♦ ║",
		"║ ♦   ♦ ║",
		"║ ♦   ♦ ║",
		"║      6║"
		)
	deck << d6
	d7 = Card.new(
		"dimond",
		7,
		"║7      ║",
		"║ ♦   ♦ ║",
		"║ ♦ ♦ ♦ ║",
		"║ ♦   ♦ ║",
		"║      7║"
		)
	deck << d7
	d8 = Card.new(
		"dimond",
		8,
		"║8      ║",
		"║ ♦ ♦ ♦ ║",
		"║  ♦ ♦  ║",
		"║ ♦ ♦ ♦ ║",
		"║      8║"
		)
	deck << d8
	d9 = Card.new(
		"dimond",
		9,
		"║9      ║",
		"║ ♦ ♦ ♦ ║",
		"║ ♦ ♦ ♦ ║",
		"║ ♦ ♦ ♦ ║",
		"║      9║"
		)
	deck << d9
	d10 = Card.new(
		"dimond",
		10,
		"║10     ║",
		"║♦ ♦ ♦ ♦║",
		"║ ♦   ♦ ║",
		"║♦ ♦ ♦ ♦║",
		"║     10║"
		)
	deck << d10
	dJ = Card.new(
		"dimond",
		11,
		"║J      ║",
		"║ A  ♦  ║",
		"║   C   ║",
	    "║  ♦  K ║",
		"║      J║"
		)
	deck << dJ
	dQ = Card.new(
		"dimond",
		12,
		"║Q      ║",
		"║ °\\♦/° ║",
	    "║  |°|  ║",
	    "║ @@@@@ ║",
		"║      Q║"
		)
	deck << dQ
	dK = Card.new(
		"dimond",
		13,
		"║K      ║",
		"║ ♦ ♦ ♦ ║",
		"║ |VVV| ║",
	    "║ |___| ║",
		"║      K║"
		)
	deck << dK
	dA = Card.new(
		"dimond",
		14,
		"║A♦     ║",
		"║       ║",
		"║   ♦   ║",
	    "║       ║",
		"║     ♦A║"
		)
	deck << dA
	return deck
end

start = Game.new()
card=gets.chomp.to_i
start.playermove(card)
# deck = shuffle(deck)

# puts "#{deck[0].line1} #{deck[1].line1} #{deck[2].line1} #{deck[3].line1}"
# puts "#{deck[0].line2} #{deck[1].line2} #{deck[2].line2} #{deck[3].line2}"
# puts "#{deck[0].line3} #{deck[1].line3} #{deck[2].line3} #{deck[3].line3}"
# puts "#{deck[0].line4} #{deck[1].line4} #{deck[2].line4} #{deck[3].line4}"
# puts "#{deck[0].line5} #{deck[1].line5} #{deck[2].line5} #{deck[3].line5}"
# puts "#{deck[0].line6} #{deck[1].line6} #{deck[2].line6} #{deck[3].line6}"
# puts "#{deck[0].line7} #{deck[1].line7} #{deck[2].line7} #{deck[3].line7}"

# puts "#{deck[4].line1} #{deck[5].line1} #{deck[6].line1} #{deck[7].line1}"
# puts "#{deck[4].line2} #{deck[5].line2} #{deck[6].line2} #{deck[7].line2}"
# puts "#{deck[4].line3} #{deck[5].line3} #{deck[6].line3} #{deck[7].line3}"
# puts "#{deck[4].line4} #{deck[5].line4} #{deck[6].line4} #{deck[7].line4}"
# puts "#{deck[4].line5} #{deck[5].line5} #{deck[6].line5} #{deck[7].line5}"
# puts "#{deck[4].line6} #{deck[5].line6} #{deck[6].line6} #{deck[7].line6}"
# puts "#{deck[4].line7} #{deck[5].line7} #{deck[6].line7} #{deck[7].line7}"

# puts "#{deck[8].line1} #{deck[9].line1} #{deck[10].line1} #{deck[11].line1}"
# puts "#{deck[8].line2} #{deck[9].line2} #{deck[10].line2} #{deck[11].line2}"
# puts "#{deck[8].line3} #{deck[9].line3} #{deck[10].line3} #{deck[11].line3}"
# puts "#{deck[8].line4} #{deck[9].line4} #{deck[10].line4} #{deck[11].line4}"
# puts "#{deck[8].line5} #{deck[9].line5} #{deck[10].line5} #{deck[11].line5}"
# puts "#{deck[8].line6} #{deck[9].line6} #{deck[10].line6} #{deck[11].line6}"
# puts "#{deck[8].line7} #{deck[9].line7} #{deck[10].line7} #{deck[11].line7}"

# puts "#{deck[12].line1} #{deck[13].line1} #{deck[14].line1} #{deck[15].line1}"
# puts "#{deck[12].line2} #{deck[13].line2} #{deck[14].line2} #{deck[15].line2}"
# puts "#{deck[12].line3} #{deck[13].line3} #{deck[14].line3} #{deck[15].line3}"
# puts "#{deck[12].line4} #{deck[13].line4} #{deck[14].line4} #{deck[15].line4}"
# puts "#{deck[12].line5} #{deck[13].line5} #{deck[14].line5} #{deck[15].line5}"
# puts "#{deck[12].line6} #{deck[13].line6} #{deck[14].line6} #{deck[15].line6}"
# puts "#{deck[12].line7} #{deck[13].line7} #{deck[14].line7} #{deck[15].line7}"

# puts "#{deck[16].line1} #{deck[17].line1} #{deck[18].line1} #{deck[19].line1}"
# puts "#{deck[16].line2} #{deck[17].line2} #{deck[18].line2} #{deck[19].line2}"
# puts "#{deck[16].line3} #{deck[17].line3} #{deck[18].line3} #{deck[19].line3}"
# puts "#{deck[16].line4} #{deck[17].line4} #{deck[18].line4} #{deck[19].line4}"
# puts "#{deck[16].line5} #{deck[17].line5} #{deck[18].line5} #{deck[19].line5}"
# puts "#{deck[16].line6} #{deck[17].line6} #{deck[18].line6} #{deck[19].line6}"
# puts "#{deck[16].line7} #{deck[17].line7} #{deck[18].line7} #{deck[19].line7}"

# puts "#{deck[20].line1} #{deck[21].line1} #{deck[22].line1} #{deck[23].line1}"
# puts "#{deck[20].line2} #{deck[21].line2} #{deck[22].line2} #{deck[23].line2}"
# puts "#{deck[20].line3} #{deck[21].line3} #{deck[22].line3} #{deck[23].line3}"
# puts "#{deck[20].line4} #{deck[21].line4} #{deck[22].line4} #{deck[23].line4}"
# puts "#{deck[20].line5} #{deck[21].line5} #{deck[22].line5} #{deck[23].line5}"
# puts "#{deck[20].line6} #{deck[21].line6} #{deck[22].line6} #{deck[23].line6}"
# puts "#{deck[20].line7} #{deck[21].line7} #{deck[22].line7} #{deck[23].line7}"

# puts "#{deck[24].line1} #{deck[25].line1} #{deck[26].line1} #{deck[27].line1}"
# puts "#{deck[24].line2} #{deck[25].line2} #{deck[26].line2} #{deck[27].line2}"
# puts "#{deck[24].line3} #{deck[25].line3} #{deck[26].line3} #{deck[27].line3}"
# puts "#{deck[24].line4} #{deck[25].line4} #{deck[26].line4} #{deck[27].line4}"
# puts "#{deck[24].line5} #{deck[25].line5} #{deck[26].line5} #{deck[27].line5}"
# puts "#{deck[24].line6} #{deck[25].line6} #{deck[26].line6} #{deck[27].line6}"
# puts "#{deck[24].line7} #{deck[25].line7} #{deck[26].line7} #{deck[27].line7}"

# puts "#{deck[28].line1} #{deck[29].line1} #{deck[30].line1} #{deck[30].line1}"
# puts "#{deck[28].line2} #{deck[29].line2} #{deck[30].line2} #{deck[30].line2}"
# puts "#{deck[28].line3} #{deck[29].line3} #{deck[30].line3} #{deck[30].line3}"
# puts "#{deck[28].line4} #{deck[29].line4} #{deck[30].line4} #{deck[30].line4}"
# puts "#{deck[28].line5} #{deck[29].line5} #{deck[30].line5} #{deck[30].line5}"
# puts "#{deck[28].line6} #{deck[29].line6} #{deck[30].line6} #{deck[30].line6}"
# puts "#{deck[28].line7} #{deck[29].line7} #{deck[30].line7} #{deck[30].line7}"

# puts "#{deck[31].line1} #{deck[32].line1} #{deck[33].line1} #{deck[34].line1}"
# puts "#{deck[31].line2} #{deck[32].line2} #{deck[33].line2} #{deck[34].line2}"
# puts "#{deck[31].line3} #{deck[32].line3} #{deck[33].line3} #{deck[34].line3}"
# puts "#{deck[31].line4} #{deck[32].line4} #{deck[33].line4} #{deck[34].line4}"
# puts "#{deck[31].line5} #{deck[32].line5} #{deck[33].line5} #{deck[34].line5}"
# puts "#{deck[31].line6} #{deck[32].line6} #{deck[33].line6} #{deck[34].line6}"
# puts "#{deck[31].line7} #{deck[32].line7} #{deck[33].line7} #{deck[34].line7}"

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