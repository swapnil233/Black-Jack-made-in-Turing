type hand :
    record
	ace1 : int
	ace2 : int
	ace3 : int
	ace4 : int

    end record

function addFace (x : int) : int
    if x > 10 then
	result 10
    else
	result x
    end if
end addFace

proc draw (var x : hand)
    var suit, face : int
    loop
	randint (suit, 1, 4)
	randint (face, 1, 15)
	if globalDeck (suit, face) = 0 then
	    globalDeck
