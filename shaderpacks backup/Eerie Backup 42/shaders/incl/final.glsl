varying vec2 texCoords;



#ifdef fsh

void main() {	
	vec3 color = texture2D(texture, texCoords * resolutionScale).rgb;
	ivec2 lodCoords1 = ivec2(gl_FragCoord * resolutionScale / 2);
	ivec2 lodCoords2 = ivec2(gl_FragCoord * resolutionScale / 4);
	//ivec2 lodCoords3 = ivec2(gl_FragCoord * resolutionScale / 8);
	vec3 lodTex1 = texelFetch(texture, lodCoords1, 1).rgb;
	vec3 lodTex2 = texelFetch(texture, lodCoords2, 2).rgb;
	//vec3 lodTex3 = texelFetch(texture, lodCoords3, 3).rgb;
	//color = mix(color, lodTex3, -resolutionBlobAmount);
	color = mix(color, lodTex2, -resolutionBlobAmount);
	color = mix(color, lodTex1, -resolutionBlobAmount);
	
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
