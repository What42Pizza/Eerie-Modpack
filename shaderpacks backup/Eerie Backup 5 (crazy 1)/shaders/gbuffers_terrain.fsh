#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

#include "/fns.glsl"

/* DRAWBUFFERS:0 */
void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	vec2 lm = lmcoord;

	color *= texture2D(lightmap, lm);

	vec3 skyColor = calcSkyColor();
	float depth = getDepth(texcoord.xy);
	depth = pow(depth, 1.25);
	depth = clamp(depth * 2 - 1, 0, 1);
	color.xyz = mix(color.xyz, skyColor, depth);

	gl_FragData[0] = color;
}