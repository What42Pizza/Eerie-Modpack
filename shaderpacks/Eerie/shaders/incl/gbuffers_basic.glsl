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
	
	// fog
	#include "/incl/depression.glsl"
	float fogStart = triLerp(min_fogStart, mid_fogStart, max_fogStart, depression);
	float fogEnd = triLerp(min_fogEnd, mid_fogEnd, max_fogEnd, depression);
	float fogCurve = triLerp(min_fogCurve, mid_fogCurve, max_fogCurve, depression);
	float linearDepth = length(gl_Vertex) / fogEnd;
	fogAmount = linearDepth;
	fogAmount = (fogAmount-fogStart)/(1.0-fogStart);
	fogAmount = clamp(fogAmount, 0.0, 1.0);
	fogAmount = 1.0-pow(1.0-fogAmount,fogCurve);
	fogAmount *= 1.0 - (1.0 - lmCoords.y) * (1.0 - eyeBrightnessSmooth.y / 240.0);
	
	depth = fromLinearDepth(linearDepth);
	upVec = normalize(gbufferModelView[1].xyz);
	
}

#endif
