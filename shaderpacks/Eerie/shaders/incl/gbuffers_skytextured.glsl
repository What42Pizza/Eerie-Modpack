varying vec2 texCoords;
varying vec3 upVec;



#ifdef fsh

void main() {
	vec4 albedo = texture2D(texture, texCoords);
	
	if (albedo.r < 0.5 && albedo.b < 0.5 && albedo.b < 0.5) {
		albedo.rgb *= 0.7;
	} else {
		albedo.rgb *= 0.25;
	}
	albedo.rgb = mix(vec3(getColorLum(albedo.rgb)), albedo.rgb, 1.3);
	
	albedo.a *= getHorizonMultiplier(gl_FragCoord.z, upVec);
	
	/* DRAWBUFFERS:1 */
	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

void main() {
	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	gl_Position = ftransform();
	upVec = normalize(gbufferModelView[1].xyz);
}

#endif
