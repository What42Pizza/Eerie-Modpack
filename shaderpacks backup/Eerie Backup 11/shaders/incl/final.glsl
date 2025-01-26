const float caveTransitionLow = 60;
const float caveTransitionHigh = 63;
const float fogStart = 0.25;
const float fogCurveMult = -1.5;

varying vec2 texcoord;



#ifdef fsh

uniform sampler2D gcolor;
uniform sampler2D gaux1; // isWater
uniform float eyeAltitude;

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

		vec3 outsideColor = mix(color.xyz, skyColor, clamp(depth, 0.0, 1.0));
		vec3 caveColor = mix(color.xyz, vec3(0, 0, 0), depth_raw);
		float caveLerpAmount = clamp((eyeAltitude-caveTransitionLow)/(caveTransitionHigh-caveTransitionLow), 0, 1);
		color = (isWater < 0.5 || depth_raw > SKY_DEPTH) ? mix(caveColor, outsideColor, caveLerpAmount) : color;
	#endif
	#ifdef NETHER
		float depth = getDepth(texcoord);
		depth = (fogDepth-fogStart)/(1-fogStart);
		depth += sin(2*PI*fogDepth)*fogCurveMult/10;
		color = mix(color, skyColor, depth);
	#endif


	// dstrt
	#ifdef OVERWORLD
		color = dstrt(color, 0.005);
	#endif
	#ifdef NETHER
		color = dstrt(color, 0.01);
	#endif


	gl_FragData[0] = vec4(color, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();

	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif