varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 glColor;
varying float normalShading;



#ifdef fsh

uniform sampler2D texture;

/* DRAWBUFFERS:0 */
void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;

	#include "basic_fsh.glsl"

	albedo.rgb *= 0.25;

	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

uniform float nightVision;
uniform float rainStrength;

void main() {
	#include "basic_vsh.glsl"
}

#endif