//VGA Driver in E100
//By Zachary Nofzinger
//Currently can draw:
// - pixels
// - black buffer
// - rectangles
// - text
//TODO:
// - sprites

//For new draw commands, first 2 lines are as follows:
//cpfa	vgadraw_okdraw		0		vgadraw_mem_response
//be	vgadraw_[drawfunction]	vgadraw_okdraw	vgadraw_one
//Makes sure that VGA is ready to be drawn to
//I think it's better than putting it at the end of the function so that cycles are not wasted on waiting

//vgadraw_mem_command		.data	0x80000060
//vgadraw_mem_response		.data	0x80000061
//vgadraw_mem_write		.data	0x80000062
//vgadraw_mem_x1		.data	0x80000063
//vgadraw_mem_y1		.data	0x80000064
//vgadraw_mem_x2		.data	0x80000065
//vgadraw_mem_y2		.data	0x80000066
//vgadraw_mem_color_write	.data	0x80000067
//vgadraw_mem_color_read	.data	0x80000068

//Draw a single pixel to the screen
//Call vgadraw_pixel
//Change variable vgadraw_x for pixel x location [0,639]
//Change variable vgadraw_y for pixel y location [0,479]
//Change variable vgadraw_color for pixel color  ARRRRRGGGGGBBBBB
//Change variable vgadraw_ra for return address

vgadraw_pixel		be	vgadraw_pixel		0x80000061	vgadraw_one
			cp	0x80000063		vgadraw_x//		vgadraw_mem_x1
			cp	0x80000064		vgadraw_y//		vgadraw_mem_y1
			cp	0x80000065		vgadraw_x//		vgadraw_mem_x2
			cp	0x80000066		vgadraw_y//		vgadraw_mem_y2
			cp	0x80000067		vgadraw_color//		vgadraw_mem_color_write
			cp	0x80000062		vgadraw_one//		vgadraw_mem_write
			cp	0x80000060		vgadraw_one//		vgadraw_mem_command
			be	vgadraw_pixel_ok	0		0

//Internally used function, does final check of vga drawing
vgadraw_pixel_ok	be	vgadraw_pixel_ok	0x80000061	vgadraw_zero
			cp	0x80000060		vgadraw_zero//		vgadraw_mem_command
			ret	vgadraw_ra

//Clears the screen buffer to black
//Call vgadraw_black
//Change variable vgadraw_ra for return address
vgadraw_black		be	vgadraw_black		0x80000061	vgadraw_one
			cp	0x80000063		vgadraw_black_xy
			cp	0x80000064		vgadraw_black_xy
			cp	0x80000065		vgadraw_black_x2
			cp	0x80000066		vgadraw_black_y2
			cp	0x80000067		vgadraw_black_color
			cp	0x80000062		vgadraw_one
			cp	0x80000060		vgadraw_one
			be	vgadraw_pixel_ok	0		0

//Draws rectangle
//Call vgadraw_rect
//Change variable vgadraw_x for rectangle start x location [0,639]
//Change variable vgadraw_y for rectangle start y location [0,479]
//Change variable vgadraw_color for pixel color  ARRRRRGGGGGBBBBB
//Change variable vgadraw_width for width of rectangle
//Change variable vgadraw_height for height of rectangle
//Change variable vgadraw_ra for return address
vgadraw_rect		be	vgadraw_rect		0x80000061	vgadraw_one
			cp	0x80000063		vgadraw_x
			cp	0x80000064		vgadraw_y
			add	vgadraw_x2		vgadraw_x	vgadraw_width
			add	vgadraw_y2		vgadraw_y	vgadraw_height
			sub	vgadraw_x2		vgadraw_x2	vgadraw_one		//Pixel draws one more pixel from set coordinate, subtract one pixel
			sub	vgadraw_y2		vgadraw_y2	vgadraw_one
			cp	0x80000065		vgadraw_x2
			cp	0x80000066		vgadraw_y2
			cp	0x80000067		vgadraw_color
			cp	0x80000062		vgadraw_one
			cp	0x80000060		vgadraw_one
			be	vgadraw_pixel_ok	0		0

//Draws text character
//Call vgadraw_text
//Change variable vgadraw_x and vgadraw_y for upper left character corner
//Change vgadraw_color for character color
//Change vgadraw_ra for return address
//Change vgadraw_char for character to be drawn in the format [font][pointsize]_[A-Z,la-lz,0-9]
vgadraw_text		cp	vgadraw_xi		vgadraw_x			//get all variables, start x and y
			cp	vgadraw_yi		vgadraw_y
			cp	vgadraw_i		vgadraw_word			//start buffer slot inc at 31, first bit of word
			cp	vgadraw_bufferi		vgadraw_two
			cpfa	vgadraw_width		0		vgadraw_char	//width and height buffers are first 2 slots
			cpfa	vgadraw_height		1		vgadraw_char	
			add	vgadraw_width		vgadraw_width	vgadraw_x	//add to x and y to get loop pos
			add	vgadraw_height		vgadraw_height	vgadraw_y
			add	vgadraw_tempi		vgadraw_bufferi	vgadraw_char	//get character buffer 1 located at slots 2
			cpfa	vgadraw_decodeB		0		vgadraw_tempi
			
vgadraw_text_loop	be	vgadraw_text_loop	0x80000061	vgadraw_one		//Check that we can draw
			
			sr	vgadraw_decode		vgadraw_decodeB	vgadraw_i
			and	vgadraw_decode		vgadraw_decode	vgadraw_one		//get bit at i
			
			be	vgadraw_text_skipdraw	vgadraw_decode	vgadraw_zero		//skip draw if bit is 0
			
			cp	0x80000067		vgadraw_color
			cp	0x80000063		vgadraw_xi
			cp	0x80000064		vgadraw_yi
			cp	0x80000065		vgadraw_xi
			cp	0x80000066		vgadraw_yi
			cp	0x80000062		vgadraw_one
			cp	0x80000060		vgadraw_one	
			
vgadraw_text_skipdraw	sub	vgadraw_i		vgadraw_i	vgadraw_one		//increment x and i
			add	vgadraw_xi		vgadraw_xi	vgadraw_one

vgadraw_text_skipi	blt	vgadraw_text_checky	vgadraw_xi	vgadraw_width
			add	vgadraw_yi		vgadraw_yi	vgadraw_one
			cp	vgadraw_xi		vgadraw_x
			
vgadraw_text_checky	be	vgadraw_text_done	vgadraw_yi	vgadraw_height
	
			bne	vgadraw_text_drawn	vgadraw_negone	vgadraw_i		//Check if incremented over whole word
			add	vgadraw_bufferi		vgadraw_bufferi	vgadraw_one		//if time for new buffer, add one to buffer counter
			add	vgadraw_tempi		vgadraw_bufferi	vgadraw_char		//trick to get address of buffer
			cpfa	vgadraw_decodeB		0		vgadraw_tempi		//copy buffer
			cp	vgadraw_i		vgadraw_word				//set incrementer to 31
			
vgadraw_text_drawn	be	vgadraw_text_loop	vgadraw_decode	vgadraw_zero
			
vgadraw_text_wait	be	vgadraw_text_wait	0x80000061	vgadraw_zero
			cp	0x80000060		vgadraw_zero
			be	vgadraw_text_loop	0		0

vgadraw_text_done	be	vgadraw_pixel_ok	vgadraw_decode	vgadraw_one
			ret	vgadraw_ra
			

//constants	
vgadraw_negone		.data	-1
vgadraw_zero		.data	0
vgadraw_one		.data	1
vgadraw_two		.data	2
vgadraw_black_color	.data	0
vgadraw_black_xy	.data	0
vgadraw_black_x2	.data	639
vgadraw_black_y2	.data	479
vgadraw_word		.data	31

//user passed vars (width and height high-jacked by text function)
vgadraw_x	.data	0
vgadraw_y	.data	0
vgadraw_color	.data	0
vgadraw_ra	.data	0
vgadraw_width	.data	0
vgadraw_height	.data	0
vgadraw_char	.data	0

//other vars
vgadraw_okdraw	.data	0
vgadraw_x2	.data	0
vgadraw_y2	.data	0
vgadraw_xi	.data	0
vgadraw_yi	.data	0
vgadraw_decodeB	.data	0 //decode buffer
vgadraw_decode	.data	0 //decoded bit
vgadraw_i	.data	0 //bit iterator
vgadraw_bufferi	.data	0 //word iterator
vgadraw_tempi	.data	0
