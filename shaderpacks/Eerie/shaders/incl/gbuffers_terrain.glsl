varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 glColor;
varying float normalShading;
varying float depth;
varying float fogAmount;
varying vec3 upVec;
#ifdef SHOW_DANGER
	varying float isDanger;
#endif

#define LIGHT_LEVEL_CUTOFF 0.5



#ifdef fsh

void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;
	
	#include "basic_fsh.glsl"
	
	// fog
	#if defined OVERWORLD || defined NETHER
		vec3 skyColor = getSkyColor();
		skyColor *= getHorizonMultiplier(depth, upVec);
		albedo.rgb = mix(albedo.rgb, skyColor, fogAmount);
	#endif
	
	#ifdef SHOW_DANGER
		if (isDanger > 0.5) {
			albedo.rgb = mix(albedo.rgb, vec3(1.0, 0.0, 0.0), 0.75 * sqrt(1-fogAmount));
		}
	#endif
	
	/* DRAWBUFFERS:0 */
	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

uniform ivec2 eyeBrightnessSmooth;

#ifdef SHADER_TORCHLIGHT
	in vec3 at_midBlock;
#endif
in vec3 mc_Entity;

void main() {
	
	#include "basic_vsh.glsl"
	
	if (int(mc_Entity.x) == 10008) {
		glColor.rgb = dstrt(glColor.rgb, -0.3, 0.0, -0.5);
		glColor.a = 1.2;
	}
	
	#ifdef SHOW_DANGER
		float rawBlockLight = (gl_TextureMatrix[1] * gl_MultiTexCoord1).x;
		isDanger = (rawBlockLight < LIGHT_LEVEL_CUTOFF) ? 1.0 : 0.0;
	#endif
	
	// fog
	#include "/incl/fog_data.glsl"
	float linearDepth = length(gl_Vertex) / fogEnd;
	fogAmount = linearDepth;
	fogAmount = (fogAmount-fogStart)/(1-fogStart);
	fogAmount = clamp(fogAmount, 0.0, 1.0);
	fogAmount = 1-pow(1-fogAmount,fogCurve);
	
	depth = fromLinearDepth(linearDepth);
	upVec = normalize(gbufferModelView[1].xyz);
	
}

#endif
