gl_Position = ftransform();
texCoords = gl_MultiTexCoord0.st;
lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;

#ifdef OVERWORLD
	lmCoords = adjustBrightness(lmCoords);
	lmCoords.y = max(lmCoords.y * 1.5 - 0.5, 0.0);
	float ymin = (1.0 - eyeBrightnessSmooth.x / 240.0) * NIGHT_BRIGHTNESS;
	float ymax = ymin + (1.0 - ymin) * getSunlightPercent();
	lmCoords.y = min(lmCoords.y, ymax);
	lmCoords.y *= 1 - (rainStrength * lightRainDecreaseAmount);
#elif defined NETHER
	lmCoords = adjustBrightness(lmCoords);
	const float maxBrightness = 1.5;
	const float brightnessSlope = 2.75;
	lmCoords.x = max(lmCoords.x * brightnessSlope - brightnessSlope + maxBrightness, 0.5);
#elif defined END
	lmCoords.y = 0.65;
#endif
lmCoords = max(lmCoords, vec2(0.0));
lmCoords.x *= lmCoords.x;

glColor = gl_Color;
if (glColor.rgb != vec3(1.0)) {
	glColor.rgb = mix(vec3(getColorLum(glColor.rgb)), glColor.rgb, glColorSaturation) * glColorTint;
}

vec3 separateNormals = (gl_Normal + normalsSlope-1) / normalsSlope;
normalShading = separateNormals.r * 0.25 + separateNormals.g * 0.55 + separateNormals.b * 0.2;
