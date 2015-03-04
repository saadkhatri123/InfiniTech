//RNG test driver
//Accepts any keyboard hit as rng time get

	call	ps2		ps2_ra
	cp	rng_seed	0x80000005
	call	rng		rng_ra
	cp	result		rng_seed
	div	mod_r		result		mod		// | Modulus
	mult	mod_r		mod_r		mod		// |
	sub	result		result		mod_r		// |
	halt
result	.data	0
mod	.data	100
mod_r	.data	0


#include keyboard_driver.e
#include rand.e