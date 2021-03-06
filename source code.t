% Swapnil Iqbal
% Started November 25, 2016
% Betting system added December 8, 2016
% Mouse Over added December 17, 2016
% Loan/more money added December 18, 2016
% WIN COUNT added in Dec. 18, 2016
% Fully finished : December 18, 2016

type hand :

    record
	cardFace : array 1 .. 15 of int
	cardSuit : array 1 .. 15 of int
	total : int
	name : string
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
var Mx, My, button : int

var font1 := Font.New ("serif:25")
var font2 := Font.New ("serif:65")
var font3 := Font.New ("sans serif:18:bold")
var font4 := Font.New ("serif:20")
var font5 := Font.New ("serif:10")
var font6 := Font.New ("serif:10")
var font7 := Font.New ("serif:18:bold")

var mymoney, pcmoney : int
var wincount : int
wincount := 0
var pcwincount : int
pcwincount := 0
var bet : int
mymoney := 100


proc intro

    drawfill (1, 1, black, black)

    Font.Draw ("BLACK JACK", 60, 300, font2, white)
    Draw.Box (maxx div 2 - 80, 200, maxx div 2 + 85, 250, white)
    Font.Draw ("Start Game", maxx div 2 - 70, 215, font1, white)
    Font.Draw ("Instructions: click start game, place bet and play", 40, 140, font3, white)
    Font.Draw ("By: Swapnil Iqbal", 390, 10, font1, white)

    loop
	Mouse.Where (Mx, My, button)
	if Mx > 240 and Mx < 405 and My > 197 and My < 250 and button = 1 then
	    delay (500)
	    cls
	    drawfill (1, 1, green, green)
	    exit
	end if
    end loop

end intro

intro

delay (300)

proc gameover
    cls
    drawfill (0, 0, black, black)
    Font.Draw ("GAME OVER", maxx div 2 - 250, maxy div 2, font2, white)
    delay (3000)
    break
end gameover

proc initDeck (var x : array 1 .. 4, 1 .. 13 of int)

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

function addFaces (x : int) : int

    if x > 10 then
	result 10
    else
	result x
    end if

end addFaces

player.name := "player"
computer.name := "computer"

procedure printCard (x : hand, suit : int, face : int)

    if x.name = "player" then

	if x.cardCount < 3 then
	    delay (300)
	    Pic.Draw (globalPicDeck (suit, face), maxx div 3 + 80 * x.cardCount, 75, 0)

	    if x.cardCount = 1 then
		delay (500)
		Pic.Draw (back, maxx div 3 + 80 * x.cardCount, 75, 0)
	    end if

	elsif x.cardCount > 2 then
	    delay (300)
	    Pic.Draw (globalPicDeck (suit, face), maxx div 3 + 80 * x.cardCount, 75, 0)
	end if
    end if

    if x.name = "computer" then

	if x.cardCount < 3 then
	    delay (300)
	    Pic.Draw (globalPicDeck (suit, face), maxx div 3 + 80 * x.cardCount, 205, 0)

	    if x.cardCount = 1 then
		Pic.Draw (back, maxx div 3 + 80 * x.cardCount, 205, 0)
	    end if

	elsif x.cardCount > 2 then
	    Pic.Draw (globalPicDeck (suit, face), maxx div 3 + 80 * x.cardCount, 205, 0)
	end if
    end if

end printCard

procedure draw (var x : hand)

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

		%ACE **************************************
		if x.aceCount = 1 and x.total > 21 then
		    x.total := x.total - 10
		elsif x.aceCount = 1 and x.total = 11 then
		    x.total := x.total + 10
		end if
		%ACE **************************************

	    end if
	    exit
	end if
    end loop

end draw

%LOANING SYSTEM WHEN YOU ARE ALL OUT OF MONEY **************************************************************
proc loan
    if mymoney = 0 then
	delay (100)
	Font.Draw ("More money?", 470, 370, font3, black)
    end if

    loop
	Mouse.Where (Mx, My, button)
	if Mx > 465 and Mx < 650 and My > 365 and My < 400 and button = 1 then
	    mymoney := mymoney + Rand.Int (1, 50)
	    Draw.FillBox (155, 70, 210, 100, green)
	    delay (500)
	    Draw.Text (intstr (mymoney), 154, 80, font3, yellow)
	    exit
	end if
    end loop
end loan
%LOANING SYSTEM WHEN YOU ARE ALL OUT OF MONEY **************************************************************

%BETTING SYSTEM ********************************************************************************************
procedure betmoney

    loop

	Font.Draw ("You Have: $", 20, 80, font3, yellow)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)
	Font.Draw ("PLACE BET: $", 420, 180, font3, yellow)
	locatexy (590, 191 + 10 div 11)
	get bet
	if bet <= mymoney and bet not= 0 then
	    Draw.FillBox (583, 201, 620, 251 div 11, green)
	    Font.Draw (intstr (bet), 583, 180, font3, yellow)
	    exit
	elsif bet = 0 then
	    locatexy (1, 400)
	    put "You didn't bet anything"
	elsif bet > mymoney then
	    locatexy (1, 400)
	    put "Bet must be from $0 to $", mymoney
	    Draw.FillBox (1, 320, 250, 400, green)
	    delay (500)
	    if mymoney = 0 then
		loan
	    end if
	elsif bet < 0 then
	    locatexy (1, 400)
	    put "No negative numbers"
	    delay (500)
	elsif bet < mymoney or
		bet > 0 then
	    exit
	end if
    end loop
end betmoney
%BETTING SYSTEM ********************************************************************************************

procedure game

    colourback (green)
    Draw.FillBox (0, 0, maxx, maxy, green)

    betmoney
    Font.Draw ("Dealer:", 50, maxy div 2 + 50, font3, yellow)
    delay (100)
    Font.Draw ("You:", 55, maxy div 2 - 80, font3, yellow)
    delay (100)
    Draw.Box (245, 30, 300, 60, black)
    Font.Draw ("Hit", 250, 35, font1, black)
    Draw.Box (425 + 5, 30, 483 + 30, 60, black)
    Font.Draw ("Stand", 400 + 35, 35, font1, black)
    Font.Draw ("Restart Game", 10, 10, font3, black)

    draw (player)
    draw (player)

    Draw.Text (intstr (player.total), 114, 118, font3, yellow)

    draw (computer)
    draw (computer)

    loop

	%RESTART GAME **************************************************************************************
	Mouse.Where (Mx, My, button)
	if Mx > 10 and Mx < 160 and My > 10 and My < 25 and button = 1 then
	    cls
	    initialize (player)
	    initialize (computer)
	    newGame (globalDeck)
	    game
	end if
	%RESTART GAME **************************************************************************************

	%EXITS GAME ****************************************************************************************
	Font.Draw ("Exit Game", 515, 10, font3, black)
	if Mx > 518 and Mx < 700 and My > 10 and My < 30 and button = 1 then
	    locatexy (1, 400)
	    put "Game will now exit..."
	    delay (500)
	    break
	end if
	%EXITS GAME ****************************************************************************************

	%MOUSEOVER *****************************************************************************************
	if Mx > 290 and Mx < 365 and My > 78 and My < 175 then
	    delay (25)
	    Pic.Draw (globalPicDeck (player.cardSuit (2), player.cardFace (2)), maxx div 3 + 80, 75, 0)
	else
	    Pic.Draw (back, maxx div 3 + 80, 75, 0)
	end if
	%MOUSEOVER *****************************************************************************************

	%HIT & STAND ***************************************************************************************
	if Mx > 245 and Mx < 300 and My > 30 and My < 60 and button = 1 then
	    delay (50)
	    draw (player)
	    Draw.FillBox (114, 118, 140, 140, green)
	    Draw.Text (intstr (player.total), 114, 118, font3, yellow)
	    exit when player.total >= 21
	elsif Mx > 430 and Mx < 483 + 30 and My > 30 and My < 60 and button = 1 then
	    Draw.FillBox (114, 118, 140, 140, green)
	    Draw.Text (intstr (player.total), 114, 118, font3, black)
	    exit
	end if
	delay (100)
	%HIT & STAND ****************************************************************************************
    end loop

    %COMPUTER HITS TILL >=17 ********************************************************************************
    delay (500)
    Draw.Text (intstr (player.total), 114, 118, font3, black)
    if computer.total <= 16 then
	delay (1000)

	loop
	    delay (1000)
	    draw (computer)
	    exit when computer.total >= 17
	end loop

	delay (800)
	Pic.Draw (globalPicDeck (player.cardSuit (2), player.cardFace (2)), maxx div 3 + 80, 75, 0)
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	delay (1000)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)

    end if
    %COMPUTER HITS TILL >=17 ********************************************************************************


    %WIN/LOSE/TIE CONDITIONS ********************************************************************************
    if player.total = 21 and computer.total > 21 then
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	Font.Draw ("You Win", 50, 180, font3, red)
	wincount := wincount + 1
	locatexy (1,400)
	put "You won: ", wincount, " times"
	put "Dealer won: ", pcwincount, " times"
	mymoney := mymoney + bet
	Draw.FillBox (155, 70, 210, 100, green)
	delay (500)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)

    elsif computer.total = 21 and player.total = 21 then
	delay (1000)
	Font.Draw ("TIE GAME", 30, 180, font3, red)
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	Font.Draw ("Restarting...", 20, 45, font3, black)
	delay (3000)
	cls
	initialize (player)
	initialize (computer)
	newGame (globalDeck)
	game

    elsif computer.total = 17 and player.total > computer.total and player.total < 21 then
	delay (1000)
	locatexy (1, 400)
	put "YOU WIN"
	wincount := wincount + 1
	put "You won: ", wincount, " times"
	put "Dealer won: ", pcwincount, " times"
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	Font.Draw ("You Win", 50, 180, font3, red)
	mymoney := mymoney + bet
	Draw.FillBox (155, 70, 210, 100, green)
	delay (500)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)

    elsif computer.total = 17 and player.total > computer.total and player.total > 21 then
	delay (1000)
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	locatexy (1, 400)
	put "YOU BUST PC WINS"
	pcwincount := pcwincount + 1
	put "You won: ", wincount, " times"
	put "Dealer won: ", pcwincount, " times"
	Font.Draw ("Computer Wins", 20, 180, font3, red)
	mymoney := mymoney - bet
	Draw.FillBox (155, 70, 210, 100, green)
	delay (500)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)
	if mymoney = 0 then
	    if Mx > 10 and Mx < 160 and My > 10 and My < 25 and button = 1 then
		cls
		initialize (player)
		initialize (computer)
		newGame (globalDeck)
		game
		delay (1000)
	    end if
	else
	    loan
	end if

    elsif computer.total = 17 and player.total < computer.total then
	delay (1000)
	locatexy (1, 400)
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	delay (1000)
	Font.Draw ("Computer Wins", 20, 180, font3, red)
	pcwincount := pcwincount + 1
	put "You won: ", wincount, " times"
	put "Dealer won: ", pcwincount, " times"
	mymoney := mymoney - bet
	Draw.FillBox (155, 70, 210, 100, green)
	delay (500)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)
	if mymoney = 0 then
	    if Mx > 10 and Mx < 160 and My > 10 and My < 25 and button = 1 then
		cls
		initialize (player)
		initialize (computer)
		newGame (globalDeck)
		game
		delay (1000)
	    end if
	else
	    loan
	end if

    elsif player.total > 21 and computer.total > 21 then
	delay (1000)
	Font.Draw ("BOTH BUST", 40, 180, font7, red)
	Font.Draw ("Restarting...", 20, 45, font3, black)
	delay (3000)
	cls
	initialize (player)
	initialize (computer)
	newGame (globalDeck)
	game

    elsif computer.total = 21 then
	delay (1000)
	locatexy (1, 400)
	put "COMPUTER HIT BLACKJACK! YOU LOSE!"
	pcwincount := pcwincount + 1
	put "You won: ", wincount, " times"
	put "Dealer won: ", pcwincount, " times"
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	Font.Draw ("Computer Wins", 20, 180, font3, red)
	mymoney := mymoney - bet
	Draw.FillBox (155, 70, 210, 100, green)
	delay (500)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)
	if mymoney = 0 then
	    if Mx > 10 and Mx < 160 and My > 10 and My < 25 and button = 1 then
		cls
		initialize (player)
		initialize (computer)
		newGame (globalDeck)
		game
		delay (1000)
	    end if
	else
	    loan
	end if

    elsif player.total = computer.total and computer.total <= 21 and player.total <= 21 then
	delay (1000)
	Font.Draw ("TIE GAME", 30, 180, font3, red)
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	Font.Draw ("Restarting...", 20, 45, font3, black)
	delay (3000)
	cls
	initialize (player)
	initialize (computer)
	newGame (globalDeck)
	game

    elsif player.total = computer.total and computer.total > 21 and player.total > 21 then
	delay (1000)
	Font.Draw ("BOTH BUST", 40, 180, font7, red)
	Font.Draw ("Restarting...", 20, 45, font3, black)
	delay (3000)
	cls
	initialize (player)
	initialize (computer)
	newGame (globalDeck)
	game

    elsif player.total = 21 and computer.total < player.total and computer.total < 21 then
	delay (1000)
	locatexy (1, 400)
	put "BLACKJACK! YOU WIN"
	wincount := wincount + 1
	put "You won: ", wincount, " times"
	put "Dealer won: ", pcwincount, " times"
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	Font.Draw ("You Win", 50, 180, font3, red)
	mymoney := mymoney + bet
	Draw.FillBox (155, 70, 210, 100, green)
	delay (500)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)

    elsif player.total > computer.total and player.total < 21 and computer.total > 17 then
	delay (1000)
	locatexy (1, 400)
	put "Computer choose to stand"
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	Font.Draw ("You Win", 50, 180, font3, red)
	wincount := wincount + 1
	put "You won: ", wincount, " times"
	put "Dealer won: ", pcwincount, " times"
	mymoney := mymoney + bet
	Draw.FillBox (155, 70, 210, 100, green)
	delay (500)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)

    elsif player.total > 21 then
	delay (1000)
	locatexy (1, 400)
	put "YOU BUST. PC WINS"
	pcwincount := pcwincount + 1
	put "You won: ", wincount, " times"
	put "Dealer won: ", pcwincount, " times"
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	Font.Draw ("Computer wins", 20, 180, font3, red)
	mymoney := mymoney - bet
	Draw.FillBox (155, 70, 210, 100, green)
	delay (500)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)
	if mymoney = 0 then
	
	    if Mx > 10 and Mx < 160 and My > 10 and My < 25 and button = 1 then
		cls
		initialize (player)
		initialize (computer)
		newGame (globalDeck)
		game
		delay (1000)
	    end if
	    
	% else
	%     loan
	 end if

    elsif computer.total > player.total and computer.total < 21 then
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Draw.Text (intstr (computer.total), 132, 248, font3, yellow)
	delay (1000)
	Font.Draw ("Computer Wins", 20, 180, font3, red)
	pcwincount := pcwincount + 1
	locatexy (1, 400)
	put "You won: ", wincount, " times"
	put "Dealer won: ", pcwincount, " times"
	mymoney := mymoney - bet
	Draw.FillBox (155, 70, 210, 100, green)
	delay (500)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)
	if mymoney = 0 then
	    if Mx > 10 and Mx < 160 and My > 10 and My < 25 and button = 1 then
		cls
		initialize (player)
		initialize (computer)
		newGame (globalDeck)
		game
		delay (1000)
	    end if
	else
	    loan
	end if

    elsif computer.total > 21 and player.total < 21 then
	delay (1000)
	locatexy (1, 400)
	put "Computer Busted. YOU WIN"
	Pic.Draw (globalPicDeck (computer.cardSuit (2), computer.cardFace (2)), maxx div 3 + 80, 205, 0)
	Font.Draw ("You Win", 50, 180, font3, red)
	wincount := wincount + 1
	put "You won: ", wincount, " times"
	put "Dealer won: ", pcwincount, " times"
	mymoney := mymoney + bet
	Draw.FillBox (155, 70, 210, 100, green)
	delay (500)
	Draw.Text (intstr (mymoney), 154, 80, font3, yellow)
    end if

    %WIN/LOSE/TIE CONDITIONS ********************************************************************************
end game

game

% SO I CAN RESTART & DO MOUSE OVER AFTER GAME HAS FINISHED **************************************************
loop

    if Mx > 518 and Mx < 565 and My > 10 and My < 30 and button = 1 then
	locatexy (1, 400)
	put "Game will now exit..."
	delay (500)
	break
    end if

    Mouse.Where (Mx, My, button)
    if Mx > 290 and Mx < 365 and My > 78 and My < 175 then
	Pic.Draw (globalPicDeck (player.cardSuit (2), player.cardFace (2)), maxx div 3 + 80, 75, 0)
    else
	Pic.Draw (back, maxx div 3 + 80, 75, 0)
    end if

    if Mx > 10 and Mx < 130 and My > 10 and My < 25 and button = 1 then
	cls
	initialize (player)
	initialize (computer)
	newGame (globalDeck)
	game
    end if
end loop
% SO I CAN RESTART & DO MOUSE OVER AFTER GAME HAS FINISHED **************************************************
