varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 glColor;
varying float normalShading;
varying float depth;
varying float fogAmount;
varying vec3 upVec;



#ifdef fsh

void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;
	
	albedo.rgb = mix(albedo.rgb, entityColor.rgb, entityColor.a);
	
	#include "basic_fsh.glsl"
	
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

void main() {
	
	#include "basic_vsh.glsl"
	
	uint rng = uint(worldDay);
	float fogSetting = randomFloat(rng);
	fogSetting = 2*fogSetting-1;
	fogSetting = fogSetting*fogSetting*fogSetting*0.5+0.5;
	#ifdef OVEROWLRD
		fogSetting = mix(0.75, fogSetting, getSunlightPercent());
	#endif
	float fogStart = triLerp(min_fogStart, avg_fogStart, max_fogStart, fogSetting);
	float fogEnd = triLerp(min_fogEnd, avg_fogEnd, max_fogEnd, fogSetting);
	float fogCurve = triLerp(min_fogCurve, avg_fogCurve, max_fogCurve, fogSetting);
	
	// fog
	float linearDepth = length(gl_Vertex) / fogEnd;
	fogAmount = linearDepth;
	fogAmount = (fogAmount-fogStart)/(1-fogStart);
	fogAmount = clamp(fogAmount, 0.0, 1.0);
	fogAmount = 1-pow(1-fogAmount,fogCurve);
	
	depth = fromLinearDepth(linearDepth);
	upVec = normalize(gbufferModelView[1].xyz);
	
}

#endif
