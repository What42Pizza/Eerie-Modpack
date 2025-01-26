varying vec2 texCoords;
varying vec4 glColor;



#ifdef fsh

uniform sampler2D texture;
uniform sampler2D gaux2;

/* DRAWBUFFERS:0 */
void main() {
	vec4 color = texture2D(texture, texCoords) * glColor;
	vec3 aux2 = texture2D(gaux2, texCoords).rgb;

	color.rgb *= aux2.r;

	gl_FragData[0] = color;
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glColor = gl_Color;
}

#endif