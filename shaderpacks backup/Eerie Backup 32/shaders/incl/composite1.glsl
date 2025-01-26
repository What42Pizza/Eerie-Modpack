varying vec2 texCoords;



#ifdef fsh

uniform sampler2D gcolor;

/* DRAWBUFFERS:0 */
void main() {
	vec2 coords = floor(texCoords * resolution) / resolution;
	vec3 color = texture2D(gcolor, coords).rgb;
	//vec3 color = texture2D(gcolor, texCoords).rgb;

	gl_FragData[0] = vec4(color, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();

	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif