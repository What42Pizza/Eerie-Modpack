#version 120

uniform sampler2D gcolor;

varying vec2 texcoord;

#include "/fns.glsl"



/* DRAWBUFFERS:0 */
void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

//	vec3 skyColor = calcSkyColor (

	gl_FragData[0] = vec4(dstrt(color, 0.02), 1.0);
}