//By Maya Pifer 
//Returns value ps2_pressed_out as 1 if the event was a press and 0 if it was a release
//Returns ps2_ascii_out with the value of the ascii for the key that was pressed

//Sets command to 1, signaling that it is ready to start an interaction
ps2		cp	0x80000020	ps2_one

//Waits for response to be 1, signaling that the keyboard has data
ps2_wait	bne	ps2_wait	0x80000021	ps2_one

//Determines if the event was a press (1) or a release (0)
ps2_event	cp	ps2_pressed	0x80000022	

//Copies the ascii code to the needed location	
ps2_ascii_value	cp	ps2_ascii	0x80000023		
		
//Sets command to 0, signaling that it is done reading
ps2_comm0	cp	0x80000020	ps2_zero

//Waits for response to be 0, signaling that the keyboard is in idle state
ps2_wait2	bne	ps2_wait2	0x80000021	ps2_zero		

//Reutrns to where the function was called from
done		ret	ps2_ra


//Return Variables
ps2_pressed	.data	0
ps2_ascii	.data	0

//Constants
ps2_zero	.data	0
ps2_one		.data	1
ps2_seven	.data	7

