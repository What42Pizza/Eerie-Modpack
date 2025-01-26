varying vec2 texCoords;



#ifdef fsh

void main() {
	vec3 color = texture2D(texture, texCoords).rgb;
	
	
	// in liquid
	if (isEyeInWater == 1) {
		color *= inWaterTint;
	} else if (isEyeInWater == 2) {
		color *= inLavaTint;
	}
	
	
	// vignette
	#ifdef OVERWORLD
		float maxxedPlayerMood = min(playerMood, 1-pow((eyeAltitude+64)/128,2));
		float vignetteScale = pow(1-max(maxxedPlayerMood,minVignette),3);
		vec2 vignetteCoords = scaleAroundCenter(texCoords, vec2(0.9, 1.0));
		float vignette = 1-pow(distToCenterSqaured(vignetteCoords),0.5);
		vignette = 1.05*vignette*(1-vignetteScale)+vignetteScale;
		color *= vignette;
	#endif
	
	
	// night vision
	color *= pow(nightVisionTint, vec3(pow(nightVision, 0.3)));
	
	
	#if defined OVERWORLD || defined NETHER
		color = (color - 1) * 0.985 + 1;
	#endif
	
	
	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(dstrt(color, dstrtAmount1, dstrtAmount2, dstrtAmount3), 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif
