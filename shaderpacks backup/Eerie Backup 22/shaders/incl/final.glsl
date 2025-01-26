varying vec2 texCoords;



#ifdef fsh

uniform sampler2D gcolor;
uniform sampler2D gaux1; // r: isWater
uniform sampler2D gaux2; // rgb: sky color
uniform int isEyeInWater;
uniform float playerMood;

/* DRAWBUFFERS:0 */
void main() {
	vec3 color = texture2D(gcolor, texCoords).rgb;
	vec3 skyColor = texture2D(gaux2, texCoords).rgb;


	// fog
	#if defined OVERWORLD || defined NETHER
		float depth = getDepth(texCoords);
		depth = (depth > SKY_DEPTH) ? 0 : depth;
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


	// vignette
	#ifdef OVERWORLD
		float maxxedPlayerMood = min(playerMood, 1-pow((eyeAltitude+64)/128,2));
		float vignetteScale = pow(1-max(maxxedPlayerMood,0.05),3);
		vec2 vignetteTexCoords = scaleAroundCenter(texCoords, vec2(0.9, 1.0));
		float vignette = 1-pow(distToCenterSqaured(vignetteTexCoords),0.5);
		vignette = 1.05*vignette*(1-vignetteScale)+vignetteScale;
		color *= vignette;
	#endif


	gl_FragData[0] = vec4(dstrt(color, dstrtAmount), 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();

	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif