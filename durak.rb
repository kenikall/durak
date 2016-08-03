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
	"║ °\\°/° ║",
    "║  |♠|  ║",
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
	11,
	"║A      ║",
	"║       ║",
	"║   ♠   ║",
    "║       ║",
	"║      A║"
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
	"║ °\\°/° ║",
    "║  |♣|  ║",
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
	11,
	"║A      ║",
	"║       ║",
	"║   ♣   ║",
    "║       ║",
	"║      A║"
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
	"║ °\\°/° ║",
    "║  |♥|  ║",
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
	11,
	"║A      ║",
	"║       ║",
	"║   ♥   ║",
    "║       ║",
	"║      A║"
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
	"║ °\\°/° ║",
    "║  |♦|  ║",
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
	11,
	"║A      ║",
	"║       ║",
	"║   ♦   ║",
    "║       ║",
	"║      A║"
	)
deck << dA

#deck.each{|test|
	puts "#{c6.line1} #{d6.line1} #{s6.line1} #{h6.line1}"
	puts "#{c6.line2} #{d6.line2} #{s6.line2} #{h6.line2}"
	puts "#{c6.line3} #{d6.line3} #{s6.line3} #{h6.line3}"
	puts "#{c6.line4} #{d6.line4} #{s6.line4} #{h6.line4}"
	puts "#{c6.line5} #{d6.line5} #{s6.line5} #{h6.line5}"
	puts "#{c6.line6} #{d6.line6} #{s6.line6} #{h6.line6}"
	puts "#{c6.line7} #{d6.line7} #{s6.line7} #{h6.line7}"

	puts "#{c7.line1} #{d7.line1} #{s7.line1} #{h7.line1}"
	puts "#{c7.line2} #{d7.line2} #{s7.line2} #{h7.line2}"
	puts "#{c7.line3} #{d7.line3} #{s7.line3} #{h7.line3}"
	puts "#{c7.line4} #{d7.line4} #{s7.line4} #{h7.line4}"
	puts "#{c7.line5} #{d7.line5} #{s7.line5} #{h7.line5}"
	puts "#{c7.line6} #{d7.line6} #{s7.line6} #{h7.line6}"
	puts "#{c7.line7} #{d7.line7} #{s7.line7} #{h7.line7}"

	puts "#{c8.line1} #{d8.line1} #{s8.line1} #{h8.line1}"
	puts "#{c8.line2} #{d8.line2} #{s8.line2} #{h8.line2}"
	puts "#{c8.line3} #{d8.line3} #{s8.line3} #{h8.line3}"
	puts "#{c8.line4} #{d8.line4} #{s8.line4} #{h8.line4}"
	puts "#{c8.line5} #{d8.line5} #{s8.line5} #{h8.line5}"
	puts "#{c8.line6} #{d8.line6} #{s8.line6} #{h8.line6}"
	puts "#{c8.line7} #{d8.line7} #{s8.line7} #{h8.line7}"

	puts "#{c9.line1} #{d9.line1} #{s9.line1} #{h9.line1}"
	puts "#{c9.line2} #{d9.line2} #{s9.line2} #{h9.line2}"
	puts "#{c9.line3} #{d9.line3} #{s9.line3} #{h9.line3}"
	puts "#{c9.line4} #{d9.line4} #{s9.line4} #{h9.line4}"
	puts "#{c9.line5} #{d9.line5} #{s9.line5} #{h9.line5}"
	puts "#{c9.line6} #{d9.line6} #{s9.line6} #{h9.line6}"
	puts "#{c9.line7} #{d9.line7} #{s9.line7} #{h9.line7}"

	puts "#{c10.line1} #{d10.line1} #{s10.line1} #{h10.line1}"
	puts "#{c10.line2} #{d10.line2} #{s10.line2} #{h10.line2}"
	puts "#{c10.line3} #{d10.line3} #{s10.line3} #{h10.line3}"
	puts "#{c10.line4} #{d10.line4} #{s10.line4} #{h10.line4}"
	puts "#{c10.line5} #{d10.line5} #{s10.line5} #{h10.line5}"
	puts "#{c10.line6} #{d10.line6} #{s10.line6} #{h10.line6}"
	puts "#{c10.line7} #{d10.line7} #{s10.line7} #{h10.line7}"

	puts "#{cJ.line1} #{dJ.line1} #{sJ.line1} #{hJ.line1}"
	puts "#{cJ.line2} #{dJ.line2} #{sJ.line2} #{hJ.line2}"
	puts "#{cJ.line3} #{dJ.line3} #{sJ.line3} #{hJ.line3}"
	puts "#{cJ.line4} #{dJ.line4} #{sJ.line4} #{hJ.line4}"
	puts "#{cJ.line5} #{dJ.line5} #{sJ.line5} #{hJ.line5}"
	puts "#{cJ.line6} #{dJ.line6} #{sJ.line6} #{hJ.line6}"
	puts "#{cJ.line7} #{dJ.line7} #{sJ.line7} #{hJ.line7}"

	puts "#{cQ.line1} #{dQ.line1} #{sQ.line1} #{hQ.line1}"
	puts "#{cQ.line2} #{dQ.line2} #{sQ.line2} #{hQ.line2}"
	puts "#{cQ.line3} #{dQ.line3} #{sQ.line3} #{hQ.line3}"
	puts "#{cQ.line4} #{dQ.line4} #{sQ.line4} #{hQ.line4}"
	puts "#{cQ.line5} #{dQ.line5} #{sQ.line5} #{hQ.line5}"
	puts "#{cQ.line6} #{dQ.line6} #{sQ.line6} #{hQ.line6}"
	puts "#{cQ.line7} #{dQ.line7} #{sQ.line7} #{hQ.line7}"

	puts "#{cK.line1} #{dK.line1} #{sK.line1} #{hK.line1}"
	puts "#{cK.line2} #{dK.line2} #{sK.line2} #{hK.line2}"
	puts "#{cK.line3} #{dK.line3} #{sK.line3} #{hK.line3}"
	puts "#{cK.line4} #{dK.line4} #{sK.line4} #{hK.line4}"
	puts "#{cK.line5} #{dK.line5} #{sK.line5} #{hK.line5}"
	puts "#{cK.line6} #{dK.line6} #{sK.line6} #{hK.line6}"
	puts "#{cK.line7} #{dK.line7} #{sK.line7} #{hK.line7}"

	puts "#{cA.line1} #{dA.line1} #{sA.line1} #{hA.line1}"
	puts "#{cA.line2} #{dA.line2} #{sA.line2} #{hA.line2}"
	puts "#{cA.line3} #{dA.line3} #{sA.line3} #{hA.line3}"
	puts "#{cA.line4} #{dA.line4} #{sA.line4} #{hA.line4}"
	puts "#{cA.line5} #{dA.line5} #{sA.line5} #{hA.line5}"
	puts "#{cA.line6} #{dA.line6} #{sA.line6} #{hA.line6}"
	puts "#{cA.line7} #{dA.line7} #{sA.line7} #{hA.line7}"

#}
# puts "╔═══════╗"
# puts "║10     ║"
# puts "║       ║"
# puts "║   ♠   ║"
# puts "║       ║"
# puts "║     10║"
# puts "╚═══════╝"

# puts "╔═══════╗"
# puts "║10     ║"
# puts "║♠ ♠ ♠ ♠║"
# puts "║ ♠   ♠ ║"
# puts "║♠ ♠ ♠ ♠║"
# puts "║     10║"
# puts "╚═══════╝"

# puts "╔═══════╗"
# puts "║ ##### ║"
# puts "║ #   # ║"
# puts "║ #   # ║"
# puts "║ #   # ║"
# puts "║ ##### ║"
# puts "╚═══════╝"

# puts "╔═══════╗\n║ Hello ║\n╚═══════╝"
# puts "♠ ♣ ♦ ♥"