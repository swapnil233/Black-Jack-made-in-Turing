%Swapnil
%October 28, 2016

var deck : array 1 .. 4, 1 .. 13 of int
var face, suit : int
var newCard : boolean
var picDeck : array 1 .. 4, 1 .. 13 of int
var x : array 1 .. 4, 1 .. 13 of int
var total : int := 0
var back : int := Pic.FileNew ("back red.bmp")
var Mx, My, button : int
var font1 := Font.New ("serif:25")

drawfill (1, 1, green, green)

proc newGame (var x : array 1 .. 4, 1 .. 13 of int)

    for i : 1 .. 4
	for j : 1 .. 13
	    x (i, j) := 0
	end for
    end for

end newGame

newGame (deck)

proc initDeck (var x : array 1 .. 4, 1 .. 13 of int)

    for m : 1 .. 4
	for n : 1 .. 13
	    if m = 1 then
		x (m, n) := Pic.FileNew ("c" + intstr (n) + ".bmp")
	    elsif m = 2 then
		x (m, n) := Pic.FileNew ("d" + intstr (n) + ".bmp")
	    elsif m = 3 then
		x (m, n) := Pic.FileNew ("h" + intstr (n) + ".bmp")
	    elsif m = 4 then
		x (m, n) := Pic.FileNew ("s" + intstr (n) + ".bmp")
	    end if

	end for
    end for

end initDeck

initDeck (picDeck)

randint (suit, 1, 4)
randint (face, 1, 13)

procedure displayCards (suit : int, face : int)

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
	Pic.Draw (picDeck (suit, face), 80, 210, 0)
	if face >= 10 then
	    total := total + 10
	elsif face <= 10 then
	    total := total + face
	end if
    end if

end displayCards

displayCards (suit, face) %back

randint (suit, 1, 4)
randint (face, 1, 13)

procedure displayRandomDeck (var x : array 1 .. 4, 1 .. 13 of int)

    newCard := false
    var count : int := 0

    loop
	randint (suit, 1, 4)
	randint (face, 1, 13)

	if deck (suit, face) = 0 then
	    count := count + 1
	    deck (suit, face) := 1

	    Pic.Draw (x (suit, face), 100, 180, 0)
	    %            x (suit, face) := 1 CLEANUP
	end if

	exit when count = 2

    end loop

    if face > 11 then
	total := total + 10
    elsif face < 11 then
	total := total + face
    end if
    % Font.Draw ("Your Total: ", maxx div 2, maxy, font1, black)
    put "total of the 2 cards: ", total

    % If mouse hovers over, display the
    loop
	Mouse.Where (Mx, My, button)
	if Mx > 100 and Mx < 170 and My > 180 and My < 280 then
	    Pic.Draw (x (suit, face), 100, 180, 0)
	else
	    Pic.Draw (back, 100, 180, 0)
	end if
    end loop

end displayRandomDeck

Font.Draw ("Hit", 250, 250, font1, black)
Font.Draw ("Stand", 350, 250, font1, black)

%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\%

% newGame (x) Doesn't do anything CLEANUP

displayRandomDeck (picDeck)

Pic.Draw (back, 100, 180, 0)

