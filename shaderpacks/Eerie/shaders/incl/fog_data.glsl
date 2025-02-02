uint rng = uint(worldDay) + 4u;
float fogSetting = randomFloat(rng);
fogSetting = 2*fogSetting-1;
fogSetting = sign(fogSetting)*fogSetting*fogSetting*0.5+0.5;
#ifdef OVERWORLD
	fogSetting = mix(0.5, fogSetting, getSunlightPercent());
#endif
float fogStart = triLerp(min_fogStart, mid_fogStart, max_fogStart, fogSetting);
float fogEnd = triLerp(min_fogEnd, mid_fogEnd, max_fogEnd, fogSetting);
float fogCurve = triLerp(min_fogCurve, mid_fogCurve, max_fogCurve, fogSetting);
