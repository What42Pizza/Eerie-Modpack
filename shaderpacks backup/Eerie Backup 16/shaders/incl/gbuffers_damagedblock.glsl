varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 glColor;



#ifdef fsh

uniform sampler2D texture;

/* DRAWBUFFERS:0 */
void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;

	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = gl_MultiTexCoord0.st;

	lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;

	glColor = gl_Color;

}

#endif