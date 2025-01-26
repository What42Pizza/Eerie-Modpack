varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 glColor;
varying float normalShading;
varying vec3 upVec;



#ifdef fsh

void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;
	
	#include "basic_fsh.glsl"
	
	// fog
	#if defined OVERWORLD || defined NETHER
	
		uint rng = uint(worldDay);
		float fogSetting = randomFloat(rng);
		fogSetting = 2*fogSetting-1;
		fogSetting = fogSetting*fogSetting*fogSetting*0.5+0.5;
		fogSetting = mix(0.75, fogSetting, getSunlightPercent());
		float fogStart = triLerp(min_fogStart, avg_fogStart, max_fogStart, fogSetting);
		float fogCurve = triLerp(min_fogCurve, avg_fogCurve, max_fogCurve, fogSetting);
		
		vec3 skyColor = getSkyColor();
		skyColor *= getHorizonMultiplier(gl_FragCoord.z, upVec);
		float fogAmount = toLinearDepth(gl_FragCoord.z) * (fogEnd / (14 * 16) + 0.6); // trial and error to get multipliers for multiple render disatances, desmos to find a line the gives good multiplier values
		fogAmount = clamp(fogAmount, 0.0, 1.0);
		fogAmount = (fogAmount-fogStart)/(1-fogStart);
		fogAmount = clamp(fogAmount, 0.0, 1.0);
		fogAmount = 1-pow(1-fogAmount,fogCurve);
		albedo.rgb = mix(albedo.rgb, skyColor, fogAmount);
		
	#endif
	
	/* DRAWBUFFERS:0 */
	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

void main() {
	
	#include "basic_vsh.glsl"
	
	upVec = normalize(gbufferModelView[1].xyz);
	
}

#endif
