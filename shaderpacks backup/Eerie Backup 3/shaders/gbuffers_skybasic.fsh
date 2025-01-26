#version 120

uniform float viewHeight;
uniform float viewWidth;
uniform mat4 gbufferProjectionInverse;

varying vec4 starData; //rgb = star color, a = flag for weather or not this pixel is a star.

const float sunPathRotation = 0.75;

#include "/fns.glsl"

/* DRAWBUFFERS:0 */
void main() {
	vec3 color;
	if (starData.a > 0.5) {
		color = starData.rgb;
	} else {
		vec4 pos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight) * 2.0 - 1.0, 1.0, 1.0);
		pos = gbufferProjectionInverse * pos;
		color = calcSkyColor(normalize(pos.xyz));
	}

	gl_FragData[0] = vec4(color, 1.0);
}