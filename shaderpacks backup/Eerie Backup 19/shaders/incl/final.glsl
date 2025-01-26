varying vec2 texCoords;



#ifdef fsh

uniform sampler2D gcolor;
uniform sampler2D gaux1; // r: isWater
uniform sampler2D gaux2; // r: horizon
uniform int isEyeInWater;
uniform float playerMood;

/* DRAWBUFFERS:0 */
void main() {
	vec3 color = texture2D(gcolor, texCoords).rgb;
	vec3 aux2 = texture2D(gaux2, texCoords).rgb;
	vec3 skyColor = getSkyColor() * aux2.r;


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
	float vignetteScale = pow(1-playerMood,3);
	vec2 vignetteTexCoords = scaleAroundCenter(texCoords, vec2(1.05, 1.0));
	float vignette = 1-pow(distToCenterSqaured(vignetteTexCoords),0.5);
	vignette = 1.05*vignette*(1-vignetteScale)+vignetteScale;
	color *= vignette;


	gl_FragData[0] = vec4(dstrt(color, dstrtAmount), 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();

	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif