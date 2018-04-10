setscreen ("graphics")

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

Draw.FillBox (0, 0, maxx, maxy, green)

var player, computer : hand
var face, suit : int
var newCard : boolean
var globalDeck : array 1 .. 4, 1 .. 13 of int
var globalPicDeck : array 1 .. 4, 1 .. 13 of int
var picDeck : array 1 .. 4, 1 .. 13 of int
var back : int := Pic.FileNew ("back.bmp")
var Mx, My, button : int %for mouse
var font1 := Font.New ("serif:25")
var font2 := Font.New ("serif:65")

% proc intro % Just the intro to the game w/ an animation
% 
%     for z : -500 .. 800
%         delay (2)
%         cls
%         Font.Draw ("BLACK JACK", z, 200, font2, red)
%     end for
% 
%     drawfill (1, 1, grey, grey)
% 
%     Font.Draw ("BLACK JACK", 60, 300, font2, black)
%     Draw.FillBox (maxx div 2 - 80, 200, maxx div 2 + 85, 250, red)
%     Font.Draw ("Start Game", maxx div 2 - 70, 215, font1, black)
% 
%     loop
%         Mouse.Where (Mx, My, button)
%         if Mx > 240 and Mx < 405 and My > 197 and My < 250 and button = 1 then
%         delay (500)
%             cls
%             drawfill (1, 1, green, green)
%             exit
%         end if
%     end loop
% 
% end intro
% 
% intro

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
		delay (500)
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
		delay (500)
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










%                                                                             MAIN                                                                 %
%Draw.Box (245, 30, 300, 60, black)
Font.Draw ("Hit", 250, 35, font1, black)

%Draw.Box (425 + 5, 30, 483 + 30, 60, black)
Font.Draw ("Stand", 400 + 35, 35, font1, black)

draw (player)
draw (player)

draw (computer)
draw (computer)

put "Computer holds: ", computer.total
put "You hold: ", player.total

loop
    Mouse.Where (Mx, My, button)
    if Mx > 245 and Mx < 300 and My > 30 and My < 60 and button = 1 then
	draw (player)
	%put "Your new total: ", player.total
    elsif
	    Mx > 430 and Mx < 483 + 30 and My > 30 and My < 60 and button = 1 and player.total > computer.total then
	delay (200)
	put "YOU WIN!"
	exit
    elsif
	    Mx > 430 and Mx < 483 + 30 and My > 30 and My < 60 and button = 1 and computer.total > player.total then
	delay (200)
	put "Computer wins"
	exit
    elsif
	    Mx > 430 and Mx < 483 + 30 and My > 30 and My < 60 and button = 1 and computer.total = player.total then
	draw (computer)
	if computer.total > player.total then
	    delay (500)
	    put "Computer decided to hit"
	    delay (200)
	    put "Computer wins..."
	end if
	exit
    end if
end loop
