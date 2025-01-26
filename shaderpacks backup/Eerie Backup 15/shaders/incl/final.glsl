varying vec2 texCoords;



#ifdef fsh

uniform sampler2D gcolor;
uniform sampler2D gaux1; // r: isWater, g: horizon
uniform int isEyeInWater;

/* DRAWBUFFERS:0 */
void main() {
	vec3 color = texture2D(gcolor, texCoords).rgb;
	vec3 skyColor = getSkyColor() * getHorizonMultiplier();


	// fog
	#ifdef OVERWORLD
		float depth = getDepth(texCoords);
		depth = (depth > SKY_DEPTH) ? 0 : depth;
		depth = (depth-fogStart)/(1-fogStart);
		depth += sin(2*PI*depth)*fogCurveMult/10;
		depth = clamp(depth, 0.0, 1.0);

		float caveLerpAmount = clamp(percentThrough(eyeAltitude, caveFogTransitionHigh, caveFogTransitionLow), 0.0, 1.0);
		vec3 fogColor = mix(skyColor, vec3(0, 0, 0), caveLerpAmount);
		color = mix(color, fogColor, depth);
	#elif defined NETHER
		float depth = getDepth(texCoords);
		depth = (depth-fogStart)/(1-fogStart);
		depth += sin(2*PI*depth)*fogCurveMult/10;
		depth = clamp(depth, 0.0, 1.0);
		color = mix(color, skyColor, depth);
	#endif


	// in liquid
	if (isEyeInWater == 1) {
		color *= inWaterTint;
	} else if (isEyeInWater == 2) {
		color *= inLavaTint;
	}


	gl_FragData[0] = vec4(dstrt(color, dstrtAmount), 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();

	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif