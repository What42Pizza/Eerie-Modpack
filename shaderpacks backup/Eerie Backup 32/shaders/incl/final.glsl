varying vec2 texCoords;



#ifdef fsh

uniform sampler2D gcolor;

/* DRAWBUFFERS:0 */
void main() {
	vec2 adjustedCoords1 = floor(texCoords * resolution) / resolution;
	vec3 colorTL = texture2D(gcolor, adjustedCoords1).rgb;
	vec2 adjustedCoords2 = adjustedCoords1 + vec2(1/resolution.x, 0);
	vec3 colorTR = texture2D(gcolor, adjustedCoords2).rgb;
	vec2 adjustedCoords3 = adjustedCoords1 + vec2(0, 1/resolution.y);
	vec3 colorBL = texture2D(gcolor, adjustedCoords3).rgb;
	vec2 adjustedCoords4 = adjustedCoords1 + vec2(1/resolution.x, 1/resolution.y);
	vec3 colorBR = texture2D(gcolor, adjustedCoords4).rgb;

	float bottomErr = adjustedCoords3.y - texCoords.y;
	float rightErr = adjustedCoords2.x - texCoords.x;
	float topBias = bottomErr * resolution.y;
	float bottomBias = 1 - topBias;
	float leftBias = rightErr * resolution.x;
	float rightBias = 1 - leftBias;

	vec3 color =
		colorTL * topBias * leftBias +
		colorTR * topBias * rightBias +
		colorBL * bottomBias * leftBias +
		colorBR * bottomBias * rightBias;

	gl_FragData[0] = vec4(color, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();

	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif