%Swapnil
%October 28, 2016

var deck : array 1 .. 4, 1 .. 13 of int
var face, suit : int
var newCard : boolean
var picDeck : array 1 .. 4, 1 .. 13 of int

% var aceOfClub : int := Pic.FileNew ("c1.bmp")
% var aceOfHears: int := Pic.FileNew
% var aceOfSpades: int := Pic.FileNew
% var aceOfdiamonds: int := Pic.FileNew
% var jack : int := Pic.FileNew
% var queen : int := Pic.FileNew
% var king : int := Pic.FileNew
% var hearts : int := Pic.FileNew
% var spade : int := Pic.FileNew
% var diamonds : int := Pic.FileNew
% var clubs : int := Pic.FileNew

proc newGame (var x : array 1 .. 4, 1 .. 13 of int)

    for i : 1 .. 4
	for j : 1 .. 13
	    x (i, j) := 0
	end for
    end for

end newGame

newGame (deck)

proc intDeck (var x : array 1 .. 4, 1 .. 13 of int)

    var tempName : string
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
    
end intDeck


randint (suit, 1, 4)
randint (face, 1, 13)


procedure displayCards (suit : int, face : int)

    if suit = 1 then
	Pic.Draw (picDeck (suit, face), maxx div 2, maxy div 2, 0)
    elsif suit = 2 then
	Pic.Draw (picDeck (suit, face), maxx div 2, maxy div 2, 0)
    elsif suit = 3 then
	Pic.Draw (picDeck (suit, face), maxx div 2, maxy div 2, 0)
    elsif suit = 4 then
	Pic.Draw (picDeck (suit, face), maxx div 2, maxy div 2, 0)
	% elsif suit = 13 then
	%     put "K" ..
    end if

end displayCards

displayCards (suit, face)

procedure displayRandomDeck (var x : array 1 .. 4, 1 .. 13 of int)

    newCard := false
    var count : int := 0

    loop
	randint (suit, 1, 4)
	randint (face, 1, 13)

	if x (suit, face) = 0 then
	    count := count + 1

	    x (suit, face) := 1
	    displayCards (suit, face)

	    if count mod 13 = 0 then
		put ""
		put ""
	    end if
	end if

	exit when count = 2
    end loop

end displayRandomDeck

displayRandomDeck (deck)
