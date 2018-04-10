var picDeck : array 1 .. 4, 1 .. 13 of int

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

intDeck (picDeck)

for p : 1 .. 4
    for q : 1 .. 13

	if p = 1 then
	    Pic.Draw (picDeck (p, q), 0, maxy - 80 - 20 * q, 0)
	elsif p = 2 then
	    Pic.Draw (picDeck (p, q), 100, maxy - 80 - 20 * q, 0)
	elsif p = 3 then
	    Pic.Draw (picDeck (p, q), 200, maxy - 80 - 20 * q, 0)
	elsif p = 4 then
	    Pic.Draw (picDeck (p, q), 300, maxy - 80 - 20 * q, 0)
	end if

    end for
end for
