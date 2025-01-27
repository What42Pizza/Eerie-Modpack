uint rng = uint(worldDay);
float fogSetting = randomFloat(rng);
fogSetting = 2*fogSetting-1;
fogSetting = fogSetting*fogSetting*fogSetting*0.5+0.5;
#ifdef OVEROWLRD
	fogSetting = mix(0.75, fogSetting, getSunlightPercent());
#endif
float fogStart = triLerp(min_fogStart, avg_fogStart, max_fogStart, fogSetting);
float fogEnd = triLerp(min_fogEnd, avg_fogEnd, max_fogEnd, fogSetting);
float fogCurve = triLerp(min_fogCurve, avg_fogCurve, max_fogCurve, fogSetting);
