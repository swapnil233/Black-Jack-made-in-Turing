type hand :

    record
	cardFace : array 1 .. 15 of int
	cardSuit : array 1 .. 15 of int
	total : int
	name : string

	%might be needed
	aceCount : int

	cardCount : int
	ace1 : int
	ace2 : int
	ace3 : int
	ace4 : int
    end record

drawfill (1, 1, green, green)

var player, computer : hand
var face, suit : int
var newCard : boolean
var globalDeck : array 1 .. 4, 1 .. 13 of int
var globalPicDeck : array 1 .. 4, 1 .. 13 of int
var picDeck : array 1 .. 4, 1 .. 13 of int
var back : int := Pic.FileNew ("back red.bmp")

proc initDeck (var x : array 1 .. 4, 1 .. 13 of int)     %initiats, and gets all the cards for the deck

    for m : 1 .. 4
	for n : 1 .. 13
	    if m = 1 then
		x (m, n) := Pic.FileNew ("c" + intstr (n) + ".bmp")     % clubs
	    elsif m = 2 then
		x (m, n) := Pic.FileNew ("d" + intstr (n) + ".bmp")     % diamonds
	    elsif m = 3 then
		x (m, n) := Pic.FileNew ("h" + intstr (n) + ".bmp")     % hearts
	    elsif m = 4 then
		x (m, n) := Pic.FileNew ("s" + intstr (n) + ".bmp")     % spades
	    end if

	end for
    end for

end initDeck

procedure initialize (var x : hand)

    for i : 1 .. 15
	x.cardSuit (i) := 0
	x.cardFace (i) := 0
    end for

    x.total := 0
    x.ace1 := 0
    x.ace2 := 0
    x.ace3 := 0
    x.ace4 := 0
    x.cardCount := 0
    x.aceCount := 0
    x.name := "player"

end initialize

initialize (player)
initialize (computer)
initDeck (globalPicDeck)

procedure newGame (var x : array 1 .. 4, 1 .. 13 of int)
    for i : 1 .. 4
	for j : 1 .. 13
	    x (i, j) := 0
	end for
    end for
end newGame

newGame (globalDeck)

%draws a random card
procedure displayCard (suit : int, face : int)

    if face = 1 then
	put 'A' ..
    elsif face > 1 and face < 11 then
	put face ..
    elsif face = 11 then
	put 'J'
    elsif face = 12 then
	put 'Q' ..
    elsif face = 13 then
	put 'K' ..
    end if

    if suit = 1 then
	put 'H' ..
    elsif suit = 2 then
	put 'S'
    elsif suit = 3 then
	put 'D'
    elsif suit = 4 then
	put 'C' ..
    end if
    put " " ..
end displayCard

%displayCard (suit, face)

function addFaces (x : int) : int

    if x > 10 then
	result 10
    else
	result x
    end if

end addFaces

player.name := "player"
computer.name := "computer"

procedure displayCards (suit : int, face : int)     %displays random card. This one is the one being overlayed.

    if suit = 1 then
	Pic.Draw (picDeck (suit, face), 80, 210, 0)
    elsif suit = 2 then
	Pic.Draw (picDeck (suit, face), 80, 210, 0)
    elsif suit = 3 then
	Pic.Draw (picDeck (suit, face), 80, 210, 0)
    elsif suit = 4 then
	Pic.Draw (picDeck (suit, face), 80, 210, 0)
    end if

end displayCards

%displayCards (suit, face) %overlayed card w/o the back showing

procedure printCard (x : hand, suit : int, face : int)

    if x.name = "player" then

	if x.cardCount < 3 then
	    Pic.Draw (globalPicDeck (suit, face), maxx div 2 + 30 * x.cardCount, 80, 0)

	    if x.cardCount = 1 then
		delay (2000)
		Pic.Draw (back, maxx div 2 + 30 * x.cardCount, 80, 0)
	    end if

	elsif x.cardCount > 2 then
	    Pic.Draw (globalPicDeck (suit, face), maxx div 2 - 30 * x.cardCount, 80, picMerge)
	end if
    end if

end printCard

procedure printCardPC (x : hand, suit : int, face : int)
    if x.name = "computer" then

	if x.cardCount < 3 then
	    Pic.Draw (globalPicDeck (suit, face), maxx div 2 + 30 * x.cardCount, 200, 0)

	    if x.cardCount = 1 then
		delay (1000)
		Pic.Draw (back, maxx div 2 + 30 * x.cardCount, 200, 0)
	    end if
	elsif x.cardCount > 2 then
	    Pic.Draw (globalPicDeck (suit, face), maxx div 2 - 30 * x.cardCount, 200, picMerge)
	end if
    end if
end printCardPC

procedure draw (var x : hand)
    var suit, face : int

    loop
	randint (suit, 1, 4)
	randint (face, 1, 13)

	if globalDeck (suit, face) = 0 then
	    globalDeck (suit, face) := 1
	    printCard (x, suit, face)
	    printCardPC (x, suit, face)
	    x.cardCount := x.cardCount + 1
	    x.cardFace (x.cardCount) := face
	    x.cardSuit (x.cardCount) := suit
	    x.total := x.total + addFaces (face)


	    if face = 1 then
		x.aceCount := x.aceCount + 1

		if x.aceCount = 1 then
		    x.ace1 := x.cardCount
		elsif x.aceCount = 2 then
		    x.ace2 := x.cardCount
		elsif x.aceCount = 3 then
		    x.ace3 := x.cardCount
		elsif x.aceCount = 4 then
		    x.ace4 := x.cardCount
		end if

	    end if
	    exit
	end if
    end loop
end draw

draw (player)
draw (player)

draw (computer)
draw (computer)

put "Your Total: ", player.total
put "Computer's Total: ", computer.total

if player.total > computer.total then put "You win!"
elsif 
computer.total > player.total then put "Computer Wins..."
end if 
