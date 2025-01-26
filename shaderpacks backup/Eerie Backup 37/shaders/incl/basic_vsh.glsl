gl_Position = ftransform();
texCoords = gl_MultiTexCoord0.st;
lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;

#ifdef OVERWORLD
	lmCoords = adjustBrightness (lmCoords);
	lmCoords.y *= getSunlightPercent();
	lmCoords.y *= 1 - (rainStrength * lightRainDecreaseAmount);
	float lightDecreasePercent = clamp(percentThrough(eyeAltitude, lightDecreaseMinY, lightDecreaseMaxY), 0, 1);
	lightDecreasePercent = min(lightDecreasePercent, getSunlightPercent());
	lmCoords.x *= lightDecreaseAmount + (1 - lightDecreaseAmount) * lightDecreasePercent;
#elif defined NETHER
	lmCoords = adjustBrightness (lmCoords);
#elif defined END
	lmCoords.y = 0.65;
#endif
lmCoords = max(lmCoords, vec2(0.0));

glColor = gl_Color;

vec3 separateNormals = (gl_Normal + normalsSlope-1) / normalsSlope;
normalShading = separateNormals.r * 0.25 + separateNormals.g * 0.55 + separateNormals.b * 0.2;
