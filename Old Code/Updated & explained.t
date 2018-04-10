%Swapnil
%October 28, 2016

% notes for myself%
% hit adds extra card. keep hitting till satisfied.
% if total becomes > 21, its a 'bust'
% stand if ur happy w/ ur current cards
% hit should add another random card, and display the new total

import GUI
var deck : array 1 .. 4, 1 .. 13 of int
var face, suit : int
var newCard : boolean
var picDeck : array 1 .. 4, 1 .. 13 of int
var font1 := Font.New ("serif:25")
var font2 := Font.New ("serif:65")
var x : array 1 .. 4, 1 .. 13 of int
var total : int := 0
var back : int := Pic.FileNew ("back red.bmp")
var Mx, My, button : int %for mouse
var hitbuttonvar : int


proc intro % Just the intro to the game w/ an animation

    % for z : -500 .. 800
    %     delay (2)
    %     cls
    %     Font.Draw ("BLACK JACK", z, 200, font2, red)
    % end for

    drawfill (1, 1, grey, grey)

    Font.Draw ("BLACK JACK", 60, 300, font2, black)
    Draw.FillBox (maxx div 2 - 80, 200, maxx div 2 + 85, 250, red)
    Font.Draw ("Start Game", maxx div 2 - 70, 215, font1, black)

    loop
	Mouse.Where (Mx, My, button)
	if Mx > 240 and Mx < 405 and My > 197 and My < 250 and button = 1 then
	    exit
	end if
    end loop

end intro

intro

drawfill (1, 1, green, green)

proc newGame (var x : array 1 .. 4, 1 .. 13 of int)

    for i : 1 .. 4
	for j : 1 .. 13
	    x (i, j) := 0
	end for
    end for

end newGame

newGame (deck)

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

initDeck (picDeck)

%randomizes the suits % faces
randint (suit, 1, 4)
randint (face, 1, 13)

procedure displayCards (suit : int, face : int) %displays random card. This one is the one being overlayed.

    if suit = 1 then
	Pic.Draw (picDeck (suit, face), 80, 210, 0)
	if face >= 10 then
	    total := total + 10
	elsif face <= 10 then
	    total := total + face
	end if
    elsif suit = 2 then
	Pic.Draw (picDeck (suit, face), 80, 210, 0)
	if face >= 10 then
	    total := total + 10
	elsif face <= 10 then
	    total := total + face
	end if
    elsif suit = 3 then
	Pic.Draw (picDeck (suit, face), 80, 210, 0)
	if face >= 10 then
	    total := total + 10
	elsif face <= 11 then
	    total := total + face
	end if
    elsif suit = 4 then

	Pic.Draw (picDeck (suit, face), 80, 210, 0) %draws the cards that applies to the if statements
	if face >= 10 then
	    total := total + 10
	elsif face <= 10 then
	    total := total + face
	end if
    end if

end displayCards

displayCards (suit, face) %overlayed card w/o the back showing

randint (suit, 1, 4)
randint (face, 1, 13)

procedure displayRandomDeck (var x : array 1 .. 4, 1 .. 13 of int) % displays the hidden card & the back

    newCard := false
    var count : int := 0

    loop
	randint (suit, 1, 4)
	randint (face, 1, 13)

	if deck (suit, face) = 0 then
	    count := count + 1
	    deck (suit, face) := 1

	    Pic.Draw (x (suit, face), 100, 180, 0)
	    % x (suit, face) := 1
	end if

	exit when count = 2

    end loop

    if face > 11 then
	total := total + 10
    elsif face < 11 then
	total := total + face
    end if
    put "You Hold: ", total

    % if total > 21 then
    %     put "bust"
    % end if

    loop     % when mouse goes over, display the the card, otherwise keep displaying the back card.
	Mouse.Where (Mx, My, button)
	if Mx > 100 and Mx < 170 and My > 180 and My < 280 then
	    Pic.Draw (x (suit, face), 100, 180, 0)
	else
	    Pic.Draw (back, 100, 180, 0)
	end if
    end loop

end displayRandomDeck

procedure hitme
    Draw.Box (295, 245, 345, 275, black)
    Font.Draw ("Hit", 300, 250, font1, black)

    loop
	Mouse.Where (Mx, My, button)
	if Mx > 295 and Mx < 345 and My > 245 and My < 275 and button = 1 then
	    put "hit"
	    exit
	end if
    end loop

end hitme

procedure stand
    Draw.Box (375, 245, 458, 275, black)
    Font.Draw ("Stand", 380, 250, font1, black)

    loop
	Mouse.Where (Mx, My, button)
	if Mx > 375 and Mx < 458 and My > 245 and My < 275 and button = 1 then
	    put "stand"
	    exit
	end if
    end loop

end stand

%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\%

newGame (x)

displayRandomDeck (picDeck)
