#ifdef NETHER
	vec3 lightmapShading = blockLight * lmCoords.x;
#else
	vec3 lightmapShading = smoothMax(blockLight * lmCoords.x, skyLight * lmCoords.y, lightMaxSmoothing);
#endif
lightmapShading += nightVision * nightVisionBrightness;

albedo.rgb *= lightmapShading * normalShading;
albedo.rgb *= 1.0 + max(nightVision - (lmCoords.x + lmCoords.y) * 0.5, 0.0) * nightVisionTint * 2.0;
albedo.rgb = smoothMin(albedo.rgb, vec3(1.0), 0.1);
