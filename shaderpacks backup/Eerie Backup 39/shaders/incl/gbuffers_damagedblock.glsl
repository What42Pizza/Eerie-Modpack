varying vec2 texCoords;
varying vec4 glColor;



#ifdef fsh

void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;
	
	/* DRAWBUFFERS:0 */
	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = gl_MultiTexCoord0.st;
	
	glColor = gl_Color;
	
}

#endif
