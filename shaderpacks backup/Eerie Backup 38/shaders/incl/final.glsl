varying vec2 texCoords;



#ifdef fsh

void main() {	
	vec3 color = texture2D(texture, texCoords * resolutionScale).rgb;
	//vec3 blobColor = textureLod(texture, texCoords * resolutionScale, resolutionBlobLOD).rgb;
	vec3 blobColor = texelFetch(texture, ivec2(gl_FragCoord * resolutionScale / pow(2, resolutionBlobLOD)), resolutionBlobLOD).rgb;
	color = mix(color, blobColor, resolutionBlobAmount);
	
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
