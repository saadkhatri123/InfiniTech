start		call	vgadraw_black	vgadraw_ra			//clear buffer
		
pixel		cp	vgadraw_x	x				//draw all colors
		cp	vgadraw_y	y		
		cpfa	color		color_red	i
		cp	vgadraw_color	color		
		call	vgadraw_pixel	vgadraw_ra
		add	i		i		one
		add	x		x		one
		blt	pixel		i		totalColors
		
w_draw		cp	vgadraw_x	w1_x
		cp	vgadraw_y	w1_y
		cp	vgadraw_color	color_green
		cp	vgadraw_char	comic18_lw_ad
		call	vgadraw_text	vgadraw_ra
		cp	vgadraw_x	w2_x
		cp	vgadraw_y	w2_y
		cp	vgadraw_char	comic18_lo_ad
		call	vgadraw_text	vgadraw_ra
		cp	vgadraw_x	w3_x
		cp	vgadraw_y	w3_y
		cp	vgadraw_char	comic18_lw_ad
		call	vgadraw_text	vgadraw_ra
		
rect_start	cp	vgadraw_x	rect_x				//Draw red rectangle
		cp	vgadraw_y	rect_y
		cp	vgadraw_width	rect_width
		cp	vgadraw_height	rect_height
		cp	vgadraw_color	color_red
		call	vgadraw_rect	vgadraw_ra
		be	rect_up		rect_motionf	one				//Rectangle movement (if motionf != 1)
		add	rect_x		rect_x		one				//(x++)
		blt	rect_wait	rect_x		rect_maxx			//(if x < maxx goto rect_start)
		cp	rect_motionf	one						//(else motionf = 1)
		be	rect_wait	0		0
		
rect_up		sub	rect_x		rect_x		one				//(x--)
		blt	rect_wait	rect_minx	rect_x				//(if x < minx goto rect_start)
		cp	rect_motionf	zero						//(else motionf = 1)
		be	rect_wait	0		0
		
rect_wait	cpfa	time		0		clock
		add	etime		time		ticks_to_wait
rect_wait_loop	cpfa	time		0		clock
		blt	rect_clean	etime		time
		be	rect_wait_loop	0		0
		
rect_clean	be	rect_clean_r	rect_motionf	one
		cp	vgadraw_width	one
		cp	vgadraw_color	color_black
		call	vgadraw_rect	vgadraw_ra
		be	rect_start	0		0
		
rect_clean_r	cp	vgadraw_width	one
		add	rect_temp	rect_x		rect_width
		cp	vgadraw_x	rect_temp
		cp	vgadraw_color	color_black
		call	vgadraw_rect	vgadraw_ra
		be	rect_start	0		0

		halt

color_red	.data	0xfc00
color_green	.data	0x3e0
color_blue	.data	0x1f
color_random	.data	0x7ff0
color_random2	.data	0xc5d
color_random3	.data	0x2560
color_black	.data	0x0
totalColors	.data	6
i		.data	0
x		.data	0
y		.data	0
color		.data	0
one		.data	1
two		.data	2
zero		.data	0
rect_x		.data	50
rect_y		.data	75
rect_width	.data	200
rect_height	.data	150
rect_minx	.data	50
rect_maxx	.data	200
rect_motionf	.data	0
rect_temp	.data	0
clock		.data	0x80000005
time		.data	0
etime		.data	0
ticks_to_wait	.data	10
w1_x		.data	200
w1_y		.data	350
w2_x		.data	220
w2_y		.data	350
w3_x		.data	235
w3_y		.data	350

#include vga.e
#include comic18_lo.e //include comic sans because fun
#include comic18_lw.e



