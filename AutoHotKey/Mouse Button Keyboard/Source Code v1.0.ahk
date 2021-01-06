Array := ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","caps","space","backspace","enter",".",",","?","!"]
length := Array.Length()
setupper = 0
char = 1
forward = 0
back = 0
MsgBox, Welcome to Mouse Button Keyboard. This allows you to type with your mouse forward and back buttons. To cycle between the letters/functions, use your mouse back/forward buttons. To type the letter/use the function, press both buttons at the same time. Currently there is a-z, 0-9, capslock, space, backspace, enter, and the following 4 characters: . , ! ? (All the characters are in that order) Thank you for using Mouse Button Keyboard!

v := Array[char]
	if (setupper = 0){
		Tooltip, %v%	
	} else {
		Tooltip % Format("{:U}", v)
	}

XButton1:: ;Browser Back 1
	back = 1
	Sleep, 175
		if (forward = 1)
		{
			forward = 0
		}
		else
		{
				back = 0
				forward = 0
				if (char = 1)
				{
					char = %length%
				}
				else
				{
					char := char-1
				}
				v := Array[char]
				if (setupper = 0){
					Tooltip, %v%	
				} else {
					Tooltip % Format("{:U}", v)
				}
				Sleep, 100
			While GetKeyState("XButton1","P")
			{
				back = 0
				forward = 0
				if (char = 1)
				{
					char = %length%
				}
				else
				{
					char := char-1
				}
				v := Array[char]
				if (setupper = 0){
					Tooltip, %v%	
				} else {
					Tooltip % Format("{:U}", v)
				}
				Sleep, 100
			}
		}
Return

XButton2:: ;Browser Forward 2
	forward = 1
	Sleep, 175
		if (back = 1)
		{
			back = 0
			v := Array[char]
			if v = space
				Send, {space}
			else if v = backspace
				Send, {backspace}
			else if v = caps
				if (setupper = 1){
					setupper = 0
					Tooltip, lowercase
				} else {
					setupper = 1
					Tooltip, UPPERCASE
				}
			else if v = enter
				Send, {enter}
			else
				if (setupper = 0){
					Send, %v%	
				} else {
					Send % Format("{:U}", v)
				}
			Return
		}
		else
		{
				back = 0
				forward = 0
				if (char = length)
				{
					char = 1
				}
				else
				{
					char := char+1
				}
				v := Array[char]
				if (setupper = 0){
						Tooltip, %v%	
				} else {
						Tooltip % Format("{:U}", v)
				}
				Sleep, 100
			While GetKeyState("XButton2","P")
			{
				back = 0
				forward = 0
				if (char = length)
				{
					char = 1
				}
				else
				{
					char := char+1
				}
				v := Array[char]
				if (setupper = 0){
						Tooltip, %v%	
				} else {
						Tooltip % Format("{:U}", v)
				}
				Sleep, 100
			}
		}
Return