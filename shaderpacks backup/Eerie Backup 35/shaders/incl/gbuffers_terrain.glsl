varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 glColor;
varying float normalShading;
varying float isWater;
#ifdef SHOW_DANGER
	varying float isDanger;
#endif

#define LIGHT_LEVEL_CUTOFF 0.5



#ifdef fsh

uniform sampler2D texture;

/* DRAWBUFFERS:04 */
void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;

	#include "basic_fsh.glsl"

	#ifdef SHOW_DANGER
		if (isDanger > 0.5) {
			albedo.rgb = mix(albedo.rgb, vec3(1.0, 0.0, 0.0), 0.75);
		}
	#endif

	gl_FragData[0] = albedo;
	gl_FragData[1] = vec4(isWater, 0.0, 0.0, 1.0);
}

#endif



#ifdef vsh

in vec3 mc_Entity;
uniform float nightVision;
uniform float rainStrength;

void main() {

	#include "basic_vsh.glsl"

	isWater = (mc_Entity.x == 10008.0) ? 1.0 : 0.0;

	#ifdef SHOW_DANGER
		isDanger = (lmCoords.x < LIGHT_LEVEL_CUTOFF) ? 1.0 : 0.0;
	#endif

}

#endif