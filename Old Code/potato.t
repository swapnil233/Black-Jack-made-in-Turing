var x, y, button :int %vars for the mouse where code 
var font5 := Font.New ("serif:15")
var back : int := Pic.FileNew ("back red.bmp")

var back : int := Pic.FileNew ("back red.bmp")
    Font.Draw ("PLAY AGAIN", 10, 10, font5, black)
	 
loop %needs to be in a loop to keep on reading mouse data 

       Mouse.Where (x, y, button) %code to find data on mouse 
	
       locatexy (x,y) %locate the text to the same line as x&y 
       put " ", x, " ",  y %put mouse location 
			
       %check to see if button is hit 
       if button = 1 then 

		 locatexy (maxx div 2,maxy div 2) 
		 put "you clicked the button" 
		 
		 cls
	end if 

end loop
