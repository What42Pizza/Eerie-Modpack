varying vec2 texcoord;



#ifdef fsh

uniform sampler2D gcolor;
uniform sampler2D gaux1; // isWater
uniform float eyeAltitude;
uniform int isEyeInWater;

/* DRAWBUFFERS:0 */
void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;
	vec4 aux = texture2D(gaux1, texcoord);
	float isWater = aux.r;
	vec3 skyColor = getSkyColor();


	// fog
	#ifdef OVERWORLD
		float depth_raw = getDepth_WO_Water(texcoord);
		float depth = (depth_raw > SKY_DEPTH) ? 0 : depth_raw;
		depth = (depth-fogStart)/(1-fogStart);
		depth += sin(2*PI*depth)*fogCurveMult/10;
		depth = clamp(depth, 0.0, 1.0);

		vec3 outsideColor = mix(color.xyz, skyColor, depth);
		vec3 caveColor = mix(color.xyz, vec3(0, 0, 0), depth_raw);
		float caveLerpAmount = clamp((eyeAltitude-caveFogTransitionLow)/(caveFogTransitionHigh-caveFogTransitionLow), 0, 1);
		//color = (isWater < 0.5 || depth_raw > SKY_DEPTH) ? mix(caveColor, outsideColor, caveLerpAmount) : color;
		color = mix(caveColor, outsideColor, caveLerpAmount);
	#endif
	#ifdef NETHER
		float depth = getDepth(texcoord);
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

	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif