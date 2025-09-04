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
	float fogStart = triLerp(min_fogStart, mid_fogStart, max_fogStart, depression) + 1.0;
	float fogDensity = triLerp(min_fogDensity, mid_fogDensity, max_fogDensity, depression) * 0.9;
	float linearDepth = length(gl_Vertex);
	fogAmount = 1.0 - exp(min(fogStart - linearDepth, 0.0) * fogDensity);
	fogAmount *= 1.0 - (1.0 - lmCoords.y) * (1.0 - eyeBrightnessSmooth.y / 240.0);
	
	depth = fromLinearDepth(linearDepth);
	upVec = normalize(gbufferModelView[1].xyz);
	
}

#endif
