varying vec2 texCoords;



#ifdef fsh

uniform sampler2D gcolor;
uniform sampler2D gaux1; // r: isWater
uniform sampler2D gaux2; // r: horizonMultiplier
uniform int isEyeInWater;
uniform float playerMood;
uniform float nightVision;

/* DRAWBUFFERS:0 */
void main() {
	vec3 color = texture2D(gcolor, texCoords).rgb;


	vec3 skyColor = getSkyColor();
	#ifdef OVERWORLD
		vec3 aux2 = texture2D(gaux2, texCoords).rgb;
		float horizonMultiplier = aux2.r;
		skyColor *= aux2.r;
	#endif
	skyColor = clamp(skyColor, 0.0, 1.0); // sometimes skyColor is nan or something


	// fog
	#if defined OVERWORLD || defined NETHER
		float depth = getDepth(texCoords);
		depth = (depth > SKY_DEPTH) ? 0 : depth;
		depth = (depth-fogStart)/(1-fogStart);
		depth = clamp(depth, 0.0, 1.0);
		depth = 1-pow(1-depth,fogCurve);
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


	gl_FragData[0] = vec4(dstrt(color, dstrtAmount1, dstrtAmount2, dstrtAmount3), 1.0);
}

#endif



#ifdef vsh

uniform float nightVision;

void main() {
	gl_Position = ftransform();

	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif