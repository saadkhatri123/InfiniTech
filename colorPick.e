colorPick	cp	vgadraw_x	zero
		cp	vgadraw_y	zero
		cp	vgadraw_width	screenWidth
		cp	vgadraw_height	screenHeight
		cp	vgadraw_color	backgroundColor
		call	vgadraw_rect	vgadraw_ra
		cp	draw_click_x	click_title_x
		cp	draw_click_y	click_title_y		
		call	draw_click	draw_click_ra

		cp	vgadraw_x	click_box_x
		cp	vgadraw_y	click_box_y
		cp	vgadraw_width	click_box_w
		cp	vgadraw_height	click_box_h
		cp	vgadraw_color	click_box_c
		call	vgadraw_rect	vgadraw_ra
		
		call	draw_slide_r	slide_r_ra
		call	draw_slide_g	slide_g_ra
		call	draw_slide_b	slide_b_ra
		
colorPick_loop	cp	click_colorP_c	click_colorP_r
		sl	click_colorP_c	click_colorP_c	color_shiftAm
		or	click_colorP_c	click_colorP_c	click_colorP_g
		sl	click_colorP_c	click_colorP_c	color_shiftAm
		or	click_colorP_c	click_colorP_c	click_colorP_b
		
		cp	vgadraw_x	click_prev_x
		cp	vgadraw_y	click_prev_y
		cp	vgadraw_width	click_prev_w
		cp	vgadraw_height	click_prev_h
		cp	vgadraw_color	click_colorP_c
		call	vgadraw_rect	vgadraw_ra
		
		call	ps2_poll	ps2_ra
		be	colorPick_loop	ps2_response	zero	//Loop if no keyboard input
		be	colorPick_loop	ps2_pressed	zero	//Loop if key released
		
		be	colorPick_w	ps2_ascii	key_w
		be	colorPick_a	ps2_ascii	key_a
		be	colorPick_s	ps2_ascii	key_s
		be	colorPick_d	ps2_ascii	key_d
		be	colorPick_loop	0		0	//Loop, invalid key
		
colorPick_w	be	colorPick_loop	click_colorP_s	zero
		sub	click_colorP_s	click_colorP_s	one
		be	colorPick_loop	0		0
		
colorPick_s	be	colorPick_loop	click_colorP_s	two
		add	click_colorP_s	click_colorP_s	one
		be	colorPick_loop	0		0

		
colorPick_a	be	colorPick_a_g	click_colorP_s	one
		be	colorPick_a_b	click_colorP_s	two
		
		be	colorPick_loop	click_colorP_r	zero
		sub	click_colorP_r	click_colorP_r	one
		cp	vgadraw_x	slide_r_ix
		cp	vgadraw_y	slide_r_iy
		cp	vgadraw_color	click_box_c
		cp	vgadraw_width	slide_width
		cp	vgadraw_height	slide_height
		call	vgadraw_rect	vgadraw_ra
		sub	slide_r_ix	slide_r_ix	slide_width
		cp	vgadraw_x	slide_r_ix
		cp	vgadraw_color	slide_ic
		call	vgadraw_rect	vgadraw_ra
		be	colorPick_loop	0		0

colorPick_a_g	be	colorPick_loop	click_colorP_g	zero
		sub	click_colorP_g	click_colorP_g	one
		cp	vgadraw_x	slide_g_ix
		cp	vgadraw_y	slide_g_iy
		cp	vgadraw_color	click_box_c
		cp	vgadraw_width	slide_width
		cp	vgadraw_height	slide_height
		call	vgadraw_rect	vgadraw_ra
		sub	slide_g_ix	slide_g_ix	slide_width
		cp	vgadraw_x	slide_g_ix
		cp	vgadraw_color	slide_ic
		call	vgadraw_rect	vgadraw_ra
		be	colorPick_loop	0		0
		
colorPick_a_b	be	colorPick_loop	click_colorP_b	zero
		sub	click_colorP_b	click_colorP_b	one
		cp	vgadraw_x	slide_b_ix
		cp	vgadraw_y	slide_b_iy
		cp	vgadraw_color	click_box_c
		cp	vgadraw_width	slide_width
		cp	vgadraw_height	slide_height
		call	vgadraw_rect	vgadraw_ra
		sub	slide_b_ix	slide_b_ix	slide_width
		cp	vgadraw_x	slide_b_ix
		cp	vgadraw_color	slide_ic
		call	vgadraw_rect	vgadraw_ra
		be	colorPick_loop	0		0

		
colorPick_d	be	colorPick_d_g	click_colorP_s	one
		be	colorPick_d_b	click_colorP_s	two
		
		be	colorPick_loop	click_colorP_r	click_colorP_m
		add	click_colorP_r	click_colorP_r	one
		cp	vgadraw_x	slide_r_ix
		cp	vgadraw_y	slide_r_iy
		cp	vgadraw_color	click_box_c
		cp	vgadraw_width	slide_width
		cp	vgadraw_height	slide_height
		call	vgadraw_rect	vgadraw_ra
		add	slide_r_ix	slide_r_ix	slide_width
		cp	vgadraw_x	slide_r_ix
		cp	vgadraw_color	slide_ic
		call	vgadraw_rect	vgadraw_ra
		be	colorPick_loop	0		0
		
colorPick_d_g	be	colorPick_loop	click_colorP_g	click_colorP_m
		add	click_colorP_g	click_colorP_g	one
		cp	vgadraw_x	slide_g_ix
		cp	vgadraw_y	slide_g_iy
		cp	vgadraw_color	click_box_c
		cp	vgadraw_width	slide_width
		cp	vgadraw_height	slide_height
		call	vgadraw_rect	vgadraw_ra
		add	slide_g_ix	slide_g_ix	slide_width
		cp	vgadraw_x	slide_g_ix
		cp	vgadraw_color	slide_ic
		call	vgadraw_rect	vgadraw_ra
		be	colorPick_loop	0		0
		
colorPick_d_b	be	colorPick_loop	click_colorP_b	click_colorP_m
		add	click_colorP_b	click_colorP_b	one
		cp	vgadraw_x	slide_b_ix
		cp	vgadraw_y	slide_b_iy
		cp	vgadraw_color	click_box_c
		cp	vgadraw_width	slide_width
		cp	vgadraw_height	slide_height
		call	vgadraw_rect	vgadraw_ra
		add	slide_b_ix	slide_b_ix	slide_width
		cp	vgadraw_x	slide_b_ix
		cp	vgadraw_color	slide_ic
		call	vgadraw_rect	vgadraw_ra
		be	colorPick_loop	0		0	
		
		halt

draw_click	cp	vgadraw_y	draw_click_y
		cp	vgadraw_color	draw_click_c
		cp	draw_click_i	zero
		
draw_click_l	cp	vgadraw_x	draw_click_x
		cpfa	draw_click_char	click_title	draw_click_i
		cp	vgadraw_char	draw_click_char
		call	vgadraw_text	vgadraw_ra
		
		be	draw_click_ret	draw_click_i	draw_click_end
		
		add	draw_click_i	draw_click_i	one
		cpfa	draw_click_temp	click_title	draw_click_i
		add	draw_click_x	draw_click_x	draw_click_temp
		add	draw_click_i	draw_click_i	one
		be	draw_click_l	0		0
		
draw_click_ret	ret	draw_click_ra


draw_slide_r	cp	slide_r_c	zero
		cp	slide_r_x	slide_x
		cp	vgadraw_y	slide_r_y
		cp	vgadraw_height	slide_height
		cp	vgadraw_width	slide_width
draw_slide_r_l	cp	vgadraw_x	slide_r_x
		sl	slide_r_cs	slide_r_c	slide_r_shift
		cp	vgadraw_color	slide_r_cs
		call	vgadraw_rect	vgadraw_ra
		be	draw_slide_r_r	slide_r_c	click_colorP_m
		add	slide_r_c	slide_r_c	one
		add	slide_r_x	slide_r_x	slide_width
		be	draw_slide_r_l	0		0
draw_slide_r_r	cp	vgadraw_x	slide_r_ix
		cp	vgadraw_y	slide_r_iy
		cp	vgadraw_color	slide_ic
		call	vgadraw_rect	vgadraw_ra
		ret	slide_r_ra


draw_slide_g	cp	slide_g_c	zero
		cp	slide_g_x	slide_x
		cp	vgadraw_y	slide_g_y
		cp	vgadraw_height	slide_height
		cp	vgadraw_width	slide_width
draw_slide_g_l	cp	vgadraw_x	slide_g_x
		sl	slide_g_cs	slide_g_c	slide_g_shift
		cp	vgadraw_color	slide_g_cs
		call	vgadraw_rect	vgadraw_ra
		be	draw_slide_g_r	slide_g_c	click_colorP_m
		add	slide_g_c	slide_g_c	one
		add	slide_g_x	slide_g_x	slide_width
		be	draw_slide_g_l	0		0
draw_slide_g_r	cp	vgadraw_x	slide_g_ix
		cp	vgadraw_y	slide_g_iy
		cp	vgadraw_color	slide_ic
		call	vgadraw_rect	vgadraw_ra
		ret	slide_g_ra


draw_slide_b	cp	slide_b_c	zero
		cp	slide_b_x	slide_x
		cp	vgadraw_y	slide_b_y
		cp	vgadraw_height	slide_height
		cp	vgadraw_width	slide_width
draw_slide_b_l	cp	vgadraw_x	slide_b_x
		cp	vgadraw_color	slide_b_c
		call	vgadraw_rect	vgadraw_ra
		be	draw_slide_b_r	slide_b_c	click_colorP_m
		add	slide_b_c	slide_b_c	one
		add	slide_b_x	slide_b_x	slide_width
		be	draw_slide_b_l	0		0
draw_slide_b_r	cp	vgadraw_x	slide_b_ix
		cp	vgadraw_y	slide_b_iy
		cp	vgadraw_color	slide_ic
		call	vgadraw_rect	vgadraw_ra
		ret	slide_b_ra


//Slide vars
slide_height	.data	20
slide_width	.data	8
slide_x		.data	105
slide_r_c	.data	0
slide_r_x	.data	0
slide_r_y	.data	320
slide_r_ra	.data	0
slide_r_shift	.data	10
slide_r_cs	.data	0	//shifted
slide_g_c	.data	0
slide_g_x	.data	0
slide_g_y	.data	370
slide_g_ra	.data	0
slide_g_shift	.data	5
slide_g_cs	.data	0	//shifted
slide_b_c	.data	0
slide_b_x	.data	0
slide_b_y	.data	420
slide_b_ra	.data	0

//Slider vars for indicators
slide_ic	.data	0
slide_r_iy	.data	300
slide_r_ix	.data	105
slide_g_iy	.data	350
slide_g_ix	.data	105
slide_b_iy	.data	400
slide_b_ix	.data	105

//GUI vars
backgroundColor	.data	760	//light blue
click_title_x	.data	200
click_title_y	.data	50
click_box_x	.data	90
click_box_y	.data	275
click_box_w	.data	460
click_box_h	.data	180
click_box_c	.data	0x56b5
click_prev_x	.data	385
click_prev_y	.data	290
click_prev_w	.data	150
click_prev_h	.data	150

//Color picker vars
click_colorP_m	.data	31	//max color value
click_colorP_r	.data	0	//rgb of color picker
click_colorP_g	.data	0
click_colorP_b	.data	0
click_colorP_c	.data	0
click_colorP_s	.data	0	//currently selected color
color_shiftAm	.data	5
key_w		.data	119
key_s		.data	115
key_a		.data	97	
key_d		.data	100

//Drawing title vars
draw_click_ra	.data	0
draw_click_i	.data	0
draw_click_x	.data	0
draw_click_y	.data	0
draw_click_c	.data	0	//black
draw_click_char	.data	0
draw_click_temp	.data	0
draw_click_end	.data	8
		
#include	keyboard_driver.e
#include	vga.e
#include	constants.e
#include	./fonts/pinklemon/PinkLemonade72_C.e
#include	./fonts/pinklemon/PinkLemonade72_ll.e
#include	./fonts/pinklemon/PinkLemonade72_li.e
#include	./fonts/pinklemon/PinkLemonade72_lc.e
#include	./fonts/pinklemon/PinkLemonade72_lk.e