gl_Position = ftransform();
texCoords = gl_MultiTexCoord0.st;
lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;

#ifdef OVERWORLD
	lmCoords.y *= getSunlightPercent();
	lmCoords = adjustBrightness (lmCoords);
#elif defined NETHER
	lmCoords = adjustBrightness (lmCoords);
#elif defined END
	lmCoords.y = 0.65;
#endif

glColor = gl_Color;

vec3 separateNormals = (gl_Normal + normalsSlope-1) / normalsSlope;
normalShading = separateNormals.r * 0.25 + separateNormals.g * 0.55 + separateNormals.b * 0.2;
