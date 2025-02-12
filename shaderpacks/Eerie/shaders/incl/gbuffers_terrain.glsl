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
FLAT int block;

#define LIGHT_LEVEL_CUTOFF 0.5



#ifdef fsh

void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;
	
	if (block == 10008) {
		albedo.rgb = dstrt(albedo.rgb, -0.4, -0.1, -0.2);
		albedo.a = 0.9;
	}
	
	#include "basic_fsh.glsl"
	
	#ifdef SHOW_DANGER
		if (isDanger > 0.5) {
			albedo.rgb = mix(albedo.rgb, vec3(1.0, 0.0, 0.0), 0.7 * max(lmCoords.x * 2.0, lmCoords.y));
		}
	#endif
	
	// fog
	#if defined OVERWORLD || defined NETHER
		vec3 skyColor = getSkyColor();
		skyColor *= getHorizonMultiplier(depth, upVec);
		albedo.rgb = mix(albedo.rgb, skyColor, fogAmount);
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

vec4 getSeasonWeights() {
	float dayTime = float(worldDay % 48) + float(worldTime) / 24000.0;
	float seasonTime = dayTime / 12.0;
	if (seasonTime < 0.5) {
		float v = smoothstep(-0.5, 0.5, seasonTime);
		return vec4(v, 0.0, 0.0, 1.0 - v);
	} else if (seasonTime < 1.5) {
		float v = smoothstep(0.5, 1.5, seasonTime);
		return vec4(1.0 - v, v, 0.0, 0.0);
	} else if (seasonTime < 2.5) {
		float v = smoothstep(1.5, 2.5, seasonTime);
		return vec4(0.0, 1.0 - v, v, 0.0);
	} else if (seasonTime < 3.5) {
		float v = smoothstep(2.5, 3.5, seasonTime);
		return vec4(0.0, 0.0, 1.0 - v, v);
	} else {
		float v = smoothstep(3.5, 4.5, seasonTime);
		return vec4(v, 0.0, 0.0, 1.0 - v);
	}
}

void main() {
	
	#include "basic_vsh.glsl"
	
	block = int(mc_Entity.x);
	
	#ifdef OVERWORLD
		if (glColor.rgb != vec3(1.0) && (block / 10000) < 2) {
			vec4 seasonWeights = getSeasonWeights();
			glColor.rgb = mix(vec3(getColorLum(glColor.rgb)), glColor.rgb, 0.825 * dot(seasonSaturations, seasonWeights)) * vec3(0.94, 0.95, 1.1);
			glColor.rgb = rgb2hsv(glColor.rgb);
			glColor.r += dot(seasonHues, seasonWeights);
			glColor.rgb = hsv2rgb(glColor.rgb);
			glColor.rgb = pow(glColor.rgb, vec3(dot(seasonGammas, seasonWeights)));
		}
	#endif
	
	#ifdef SHOW_DANGER
		float rawBlockLight = (gl_TextureMatrix[1] * gl_MultiTexCoord1).x;
		isDanger = (rawBlockLight < LIGHT_LEVEL_CUTOFF) ? 1.0 : 0.0;
	#endif
	
	// fog
	#include "/incl/depression.glsl"
	float fogStart = triLerp(min_fogStart, mid_fogStart, max_fogStart, depression);
	float fogEnd = triLerp(min_fogEnd, mid_fogEnd, max_fogEnd, depression);
	float fogCurve = triLerp(min_fogCurve, mid_fogCurve, max_fogCurve, depression);
	float linearDepth = length(gl_Vertex) / fogEnd;
	fogAmount = linearDepth;
	fogAmount = (fogAmount-fogStart)/(1-fogStart);
	fogAmount = clamp(fogAmount, 0.0, 1.0);
	fogAmount = 1-pow(1-fogAmount,fogCurve);
	
	depth = fromLinearDepth(linearDepth);
	upVec = normalize(gbufferModelView[1].xyz);
	
}

#endif
