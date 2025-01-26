varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 glColor;
varying float normalShading;



#ifdef fsh

uniform sampler2D texture;
uniform vec4 entityColor;

/* DRAWBUFFERS:0 */
void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;

	albedo.rgb = mix(albedo.rgb, entityColor.rgb, entityColor.a);

	#include "basic_fsh.glsl"

	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

uniform float rainStrength;

void main() {
	#include "basic_vsh.glsl"
}

#endif