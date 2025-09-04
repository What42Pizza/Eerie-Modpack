uint rng = uint(worldDay) + 4u;
float depression = randomFloat(rng);
#ifdef OVERWORLD
	depression *= sqrt(getSunlightPercent());
#endif
