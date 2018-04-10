% Swapnil Iqbal
% November 25, 2016
% Betting system added December 8, 2016

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

var player, computer : hand
player.name := "player"
computer.name := "computer"
var face, suit : int
var newCard : boolean
var globalDeck : array 1 .. 4, 1 .. 13 of int
var globalPicDeck : array 1 .. 4, 1 .. 13 of int
var picDeck : array 1 .. 4, 1 .. 13 of int
var back : int := Pic.FileNew ("back red.bmp")
var Mx, My, button : int %for mouse
var font1 := Font.New ("serif:25")
var font5 := Font.New ("serif:15")
var font2 := Font.New ("serif:65")
var font3 := Font.New ("sans serif:18:bold")
var font4 := Font.New ("serif:20")
var win : boolean
var winCount : boolean
var mymoney : int
var bet : int
mymoney := 100

% proc intro % Just the intro to the game w/ an animation
%
%     for z : -500 .. 800
%         delay (2)
%         cls
%         Font.Draw ("BLACK JACK", z, 200, font2, red)
%         delay (1)
%         View.Update
%     end for
%
%     drawfill (1, 1, grey, grey)
%
%     Font.Draw ("BLACK JACK", 60, 300, font2, black)
%     Draw.Box (maxx div 2 - 80, 200, maxx div 2 + 85, 250, red)
%     Font.Draw ("Start Game", maxx div 2 - 70, 215, font1, black)
%
%     loop
%         Mouse.Where (Mx, My, button)
%         if Mx > 240 and Mx < 405 and My > 197 and My < 250 and button = 1 then
%             delay (500)
%             cls
%             drawfill (1, 1, green, green)
%             exit
%         end if
%     end loop
%
% end intro
%
% intro

delay (300)

proc gameover
    cls
    Font.Draw ("GAME OVER", maxx div 2 - 250, maxy div 2, font2, black)
end gameover

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
	    Pic.Draw (globalPicDeck (suit, face), maxx div 3 + 30 * x.cardCount, 80, 0)

	    if x.cardCount = 1 then
		delay (500)
		Pic.Draw (back, maxx div 3 + 30 * x.cardCount, 80, 0)
	    end if

	elsif x.cardCount > 2 then
	    Pic.Draw (globalPicDeck (suit, face), maxx div 3 + 30 * x.cardCount, 80, 0)
	end if
    end if

    if x.name = "computer" then

	if x.cardCount < 3 then
	    Pic.Draw (globalPicDeck (suit, face), maxx div 3 + 30 * x.cardCount, 200, 0)

	    if x.cardCount = 1 then
		Pic.Draw (back, maxx div 3 + 30 * x.cardCount, 200, 0)
	    end if
	elsif x.cardCount > 2 then
	    Pic.Draw (globalPicDeck (suit, face), maxx div 3 + 30 * x.cardCount, 200, 0)
	end if
    end if

end printCard

procedure draw (var x : hand)
    var suit, face : int

    loop
	randint (suit, 1, 4)
	randint (face, 1, 13)

	if globalDeck (suit, face) = 0 then
	    globalDeck (suit, face) := 1
	    printCard (x, suit, face)

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

		%*****************ACE*****************%
		if x.aceCount = 1 and x.total > 21 then
		    x.total := x.total - 10
		    %*****************ACE*****************%

		end if
	    end if
	    exit
	end if
    end loop

end draw

procedure mouseOver
    loop
	Mouse.Where (Mx, My, button)
	if Mx > 340 and Mx < 420 and My > 70 and My < 170 then
	    Pic.Draw (picDeck (player.cardSuit (2), player.cardFace (2)), maxx div 3 + 30, 80, 0)
	else
	    Pic.Draw (back, maxx div 2 + 30, 80, 0)
	end if
    end loop
end mouseOver





%*****************************************************************************************************%
procedure betmoney
    loop
	Font.Draw ("PLACE BET: $", 420, 180, font3, yellow)
	get bet
	Draw.FillBox (1, 370, 100, 400, green)
	Font.Draw (intstr (bet), 583, 180, font3, yellow)
	if bet > mymoney then
	    put "Bet must be from $0 to $", mymoney
	    Draw.FillBox (1, 370, 25, 400, red)
	    delay (500)
	    if mymoney = 0 then
		put "YOU HAVE NO MORE MONEY. GAME WILL END"
		delay (5000)

		gameover
		delay (5000)
		break
	    end if
	elsif bet < 0 then
	    put "No negative numbers"
	    delay (500)
	elsif bet < mymoney or
		bet > 0 then
	    exit
	end if
    end loop
end betmoney
%*****************************************************************************************************%





procedure game

    colourback (green)
    Draw.FillBox (0, 0, maxx, maxy, green)
    Draw.Line (0, maxy div 2 - 10, 800, maxy div 2 - 10, black)

    %Font.Draw ("Dealer:", 50, maxy div 2 + 50, font3, yellow)
    Font.Draw ("You:", 55, maxy div 2 - 80, font3, yellow)

    Draw.Box (245, 30, 300, 60, black)
    Font.Draw ("Hit", 250, 35, font1, black)
    Draw.Box (425 + 5, 30, 483 + 30, 60, black)
    Font.Draw ("Stand", 400 + 35, 35, font1, black)
    Font.Draw ("PLAY AGAIN", 10, 10, font5, black)

    draw (player)
    draw (player)

    Draw.Text (intstr (player.total), 114, 118, font3, yellow)

    draw (computer)
    draw (computer)

    Font.Draw ("You Have: $", 20, 80, font3, yellow)
    Draw.Text (intstr (mymoney), 154, 80, font3, yellow)

    %Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
    % betmoney

    %HIT and STAND
    betmoney
    loop

	Mouse.Where (Mx, My, button)
	if Mx > 10 and Mx < 130 and My > 10 and My < 25 and button = 1 then
	    cls
	    initialize (player)
	    initialize (computer)
	    newGame (globalDeck)
	    game
	end if

	if Mx > 245 and Mx < 300 and My > 30 and My < 60 and button = 1 then
	    delay (50)
	    draw (player)
	    %exit when player.total >= 21
	    Draw.FillBox (114, 118, 140, 140, green)
	    Draw.Text (intstr (player.total), 114, 118, font3, yellow)
	elsif Mx > 430 and Mx < 483 + 30 and My > 30 and My < 60 and button = 1 then
	    Draw.FillBox (114, 118, 140, 140, green)
	    Draw.Text (intstr (player.total), 114, 118, font3, black)
	    exit
	end if
	delay (100)
    end loop

    if computer.total <= 16 then
	delay (1000)
	loop
	    delay (1000)
	    draw (computer)
	    % Draw.FillBox (132, 245, 165, 270, green)
	    % Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	    exit when computer.total >= 17
	end loop
	Draw.FillBox (132, 245, 165, 270, green)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
    end if

    %STILL IN WORK%
    if computer.total = 21 and player.total = 21 then
	put "TIE. GAME PUSHED"
	cls
	initialize (player)
	initialize (computer)
	newGame (globalDeck)
	game
    elsif computer.total = 17 and player.total > computer.total then
	delay (1000)
	put "YOU WIN"
	mymoney := mymoney + bet
	put "Your wallet: ", mymoney
    elsif computer.total = 17 and player.total > computer.total and player.total > 21 then
	delay (1000)
	put "YOU BUST PC WINS"
	mymoney := mymoney - bet
	put "Your wallet: ", mymoney
    elsif computer.total = 17 and player.total < computer.total then
	delay (1000)
	put "YOU WIN"
	mymoney := mymoney + bet
	put "Your wallet: ", mymoney
    elsif player.total > 21 and computer.total > 21 then
	delay (1000)
	put "BOTH BUST. GAME OVER"
    elsif computer.total = 21 then
	delay (1000)
	put "COMPUTER HIT BLACKJACK! YOU LOSE!"
	mymoney := mymoney - bet
	put "Your wallet: ", mymoney
    elsif player.total = computer.total and computer.total < 21 and player.total < 21 then
	put "TIE. GAME PUSHED"
    elsif player.total = computer.total and computer.total > 21 and player.total > 21 then
	put "BOTH BUST. GAME OVER!"
	delay (2000)
    elsif player.total = 21 and computer.total < player.total and computer.total < 21 then
	delay (1000)
	put "BLACKJACK! YOU WIN"
	mymoney := mymoney + bet
	put "Your wallet: ", mymoney
    elsif player.total > computer.total and player.total < 21 and computer.total > 17 then
	delay (1000)
	put "Computer choose to stand"
	delay (1000)
	put "YOU WIN!"
	mymoney := mymoney + bet
	put "Your wallet: ", mymoney
    elsif player.total > 21 then
	delay (1000)
	put "YOU BUST. PC WINS"
	mymoney := mymoney - bet
	put "Your wallet: ", mymoney
    elsif computer.total > player.total and computer.total < 21 then
	delay (2000)
	put "Computer Wins."
	mymoney := mymoney - bet
	put "Your wallet: ", mymoney
    elsif computer.total > 21 then
	delay (1000)
	put "Computer Busted. YOU WIN"
	mymoney := mymoney + bet
	put "Your wallet: $", mymoney
    end if
end game

game

loop
    Mouse.Where (Mx, My, button)
    if Mx > 10 and Mx < 130 and My > 10 and My < 25 and button = 1 then
	cls
	initialize (player)
	initialize (computer)
	newGame (globalDeck)
	game
    end if
end loop

