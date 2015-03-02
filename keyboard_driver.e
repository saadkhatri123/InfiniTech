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
		cp	ps2_response	ps2_one

//Waits for response to be 0, signaling that the keyboard is in idle state
ps2_wait2	bne	ps2_wait2	0x80000021	ps2_zero		

//Reutrns to where the function was called from
ps2_done	ret	ps2_ra
		
		
//Same as normal, but only waits several cycles for response.
//Allows us to do stuff while polling keyboard every so often
//Sets ps2_response to 1 if keyboard input
//Sets command to 1, signaling that it is ready to start an interaction
ps2_poll	cp	0x80000020	ps2_one
		cp	ps2_i		ps2_zero
		cp	ps2_response	ps2_zero

ps2_poll_wait	be	ps2_done	ps2_i		ps2_max
		add	ps2_i		ps2_i		ps2_one
		bne	ps2_poll_wait	0x80000021	ps2_one
		be	ps2_event	0		0


//Return Variables
ps2_pressed	.data	0
ps2_ascii	.data	0
ps2_ra		.data	0
ps2_response	.data	0

//Constants
ps2_zero	.data	0
ps2_one		.data	1

//Other
ps2_max		.data	8
ps2_i		.data	0
