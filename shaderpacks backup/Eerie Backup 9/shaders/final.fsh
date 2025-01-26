#version 120

#define PI (3.1415926538)

const float caveTransitionLow = 60;
const float caveTransitionHigh = 63;
const float fogStart = 0.25;
const float fogCurveMult = -1.5;

uniform sampler2D gcolor;
uniform float eyeAltitude;
varying vec2 texcoord;

#include "/fns.glsl"



/* DRAWBUFFERS:0 */
void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;
	vec3 skyColor = calcSkyColor();

	float depth_raw = getDepth(texcoord);
	float fogDepth = depth_raw > 1.749 ? 0 : depth_raw;
	fogDepth = (fogDepth-fogStart)/(1-fogStart);
	fogDepth += sin(2*PI*fogDepth)*fogCurveMult/10;

	// fog
	vec3 outsideColor = mix(color.xyz, skyColor, clamp(fogDepth, 0.0, 1.0));
	vec3 caveColor = mix(color.xyz, vec3(0, 0, 0), depth_raw);
	float caveLerpAmount = clamp((eyeAltitude-caveTransitionLow)/(caveTransitionHigh-caveTransitionLow), 0, 1);
	color = mix(caveColor, outsideColor, caveLerpAmount);

	gl_FragData[0] = vec4(dstrt(color, 0.005), 1.0);
}