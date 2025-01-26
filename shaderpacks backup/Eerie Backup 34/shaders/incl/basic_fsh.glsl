#ifdef NETHER
	vec3 lightmapShading = blockLight * lmCoords.x;
#else
	vec3 lightmapShading = smoothMax(blockLight * lmCoords.x, skyLight * lmCoords.y, lightMaxSmoothing);
#endif

#ifdef OVERWORLD
	float lightDecreasePercent = clamp(percentThrough(eyeAltitude, lightDecreaseMinY, lightDecreaseMaxY), 0, 1);
	lightDecreasePercent = min(lightDecreasePercent, getSunlightPercent());
	lightmapShading *= lightDecreaseAmount + (1 - lightDecreaseAmount) * lightDecreasePercent;
#endif

albedo.rgb *= lightmapShading * normalShading;
albedo.rgb = smoothMin(albedo.rgb, vec3(1.0), 0.1);
