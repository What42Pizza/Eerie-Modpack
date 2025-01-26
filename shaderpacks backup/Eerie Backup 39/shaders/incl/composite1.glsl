varying vec2 texCoords;



#ifdef fsh

void main() {
	vec3 color = texelFetch(texture, ivec2(gl_FragCoord / resolutionScale), 0).rgb;
	
	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif
