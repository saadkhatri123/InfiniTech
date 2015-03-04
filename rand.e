//Random number generators
//Uses clock time to generate random numbers
//Uses Linear Congruential PRNG, sufficiently random
//Only set rng_seed once for best randomness
//After setting rng_seed, call

rng	cp	rng_newseed	rng_seed
	mult	rng_newseed	rng_newseed	rng_a
	div	rng_mod		rng_newseed	rng_m		// | Modulus
	mult	rng_mod		rng_mod		rng_m		// |
	sub	rng_seed	rng_newseed	rng_mod		// |
	ret	rng_ra
	
rng_seed	.data	0
rng_newseed	.data	0
rng_m		.data	2147483647
rng_a		.data	16807
rng_mod		.data	0
rng_ra		.data	0
	