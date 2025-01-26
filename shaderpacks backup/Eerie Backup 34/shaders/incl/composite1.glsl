varying vec2 texCoords;



#ifdef fsh

uniform sampler2D gcolor;
uniform float playerMood;

/* DRAWBUFFERS:0 */
void main() {
	vec2 coords = floor(texCoords * resolution) / resolution;
	coords = (coords - 0.5) * (1 - playerMood * moodZoomAmount / 10) + 0.5;
	vec3 color = texture2D(gcolor, coords).rgb;

	gl_FragData[0] = vec4(color, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();

	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif