uint rng = uint(worldDay) + 8u;
float depression = randomFloat(rng);
depression = 2.0 * depression - 1.0;
depression = sign(depression) * depression * depression * 0.5 + 0.5;
#ifdef OVERWORLD
	depression = mix(0.5, depression, getSunlightPercent());
#endif
