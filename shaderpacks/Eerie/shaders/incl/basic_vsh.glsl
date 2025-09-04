gl_Position = ftransform();
texCoords = gl_MultiTexCoord0.st;
lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;

#ifdef SHADER_TORCHLIGHT
	vec4 playerPos4 = gbufferModelViewInverse * gbufferProjectionInverse * gl_Position;
	vec3 playerPos = playerPos4.xyz / playerPos4.w;
	#ifdef GBUFFERS_TERRAIN
		playerPos += at_midBlock * 0.0001;
	#endif
	#ifdef GBUFFERS_TERRAIN
		temp = floor(playerPos + cameraPosition) + 0.5 - cameraPosition;
	#endif
	playerPos = floor(playerPos + cameraPosition) + 0.5 - cameraPosition;
	float torchLight = max(1.0 - 0.1 * length(playerPos), 0.0);
	torchLight *= heldBlockLightValue / 15.0;
	lmCoords.x = max(lmCoords.x, torchLight);
#endif

#ifdef OVERWORLD
	lmCoords = adjustBrightness(lmCoords);
	float skylightBrightness = mix(NIGHT_BRIGHTNESS * (1.0 - eyeBrightnessSmooth.x / 240.0), 1, getSunlightPercent());
	lmCoords.y = min(lmCoords.y, skylightBrightness);
	lmCoords.y *= 1 - (rainStrength * lightRainDecreaseAmount);
#elif defined NETHER
	lmCoords = adjustBrightness(lmCoords);
	const float maxBrightness = 1.4;
	const float brightnessSlope = 2.75;
	lmCoords.x = max(lmCoords.x * brightnessSlope - brightnessSlope + maxBrightness, 0.5);
#elif defined END
	lmCoords.y = 0.65;
#endif
lmCoords = max(lmCoords, vec2(0.0));
lmCoords.x *= lmCoords.x;

glColor = gl_Color;

vec3 separateNormals = (gl_Normal + normalsSlope-1) / normalsSlope;
normalShading = separateNormals.r * 0.25 + separateNormals.g * 0.55 + separateNormals.b * 0.2;
