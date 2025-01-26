#version 120

const float caveTransitionLow = 60;
const float caveTransitionHigh = 63;

uniform sampler2D gcolor;
uniform float eyeAltitude;

varying vec2 texcoord;

#include "/fns.glsl"



/* DRAWBUFFERS:0 */
void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	float depth_raw = getDepth(texcoord);
	float depth = depth_raw > 1.749 ? 0 : depth_raw;
	depth = clamp(pow(depth, 1.25) * 2 - 1, 0, 1);
	vec3 skyColor = calcSkyColor();
	vec3 outsideColor = mix(color.xyz, skyColor, depth);
	vec3 caveColor = mix(color.xyz, vec3(0, 0, 0), depth_raw);
	float caveLerpAmount = clamp((eyeAltitude-caveTransitionLow)/(caveTransitionHigh-caveTransitionLow), 0, 1);
	color = mix(caveColor, outsideColor, caveLerpAmount);

	gl_FragData[0] = vec4(dstrt(color, 0.02), 1.0);
}