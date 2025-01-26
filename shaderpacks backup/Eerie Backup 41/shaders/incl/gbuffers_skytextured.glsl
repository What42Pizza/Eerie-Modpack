varying vec2 texCoords;



#ifdef fsh

void main() {
	vec4 albedo = texture2D(texture, texCoords);
	
	albedo.rgb *= 0.25;
	
	/* DRAWBUFFERS:0 */
	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

void main() {
	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	gl_Position = ftransform();
}

#endif
