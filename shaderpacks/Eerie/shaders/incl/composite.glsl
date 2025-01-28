varying vec2 texCoords;
varying vec3 upVec;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D colortex3;
uniform sampler2D depthtex1;



#ifdef fsh

void main() {
	vec3 color = texture2D(colortex0, texCoords).rgb;
	
	
	// sky
	#include "/incl/fog_data.glsl"
	float rawDepth = texelFetch(depthtex0, ivec2(gl_FragCoord.xy), 0).r;
	#ifdef OVERWORLD
		vec4 clouds = texelFetch(colortex2, ivec2(gl_FragCoord.xy), 0);
		if (clouds.a > 0.0) {
			rawDepth = texelFetch(depthtex1, ivec2(gl_FragCoord.xy), 0).r;
		}
	#endif
	if (toLinearDepth(rawDepth) > 0.999) {
		color = getSkyColor();
		float horizonMultiplier = getHorizonMultiplier(gl_FragCoord.z, upVec);
		color *= horizonMultiplier;
	}
	#ifdef OVERWORLD
		float blockDepth = length(screenToView(vec3(texCoords, rawDepth)));
		float skyFog = clamp(percentThrough(blockDepth, fogEnd * 0.9, fogEnd), 0.0, 1.0);
		color = mix(color, texelFetch(colortex1, ivec2(gl_FragCoord.xy), 0).rgb, skyFog);
		if (clouds.a > 0.0) {
			vec3 cloudNormal = clouds.xyz * 2.0 - 1.0;
			cloudNormal.xz = abs(cloudNormal.xz);
			float sunlightPercent = getSunlightPercent();
			sunlightPercent = 1.0 - (1.0 - sunlightPercent) * (1.0 - sunlightPercent);
			sunlightPercent = max(1.0 - 1.2 * (1.0 - sunlightPercent), 0.0);
			float cloudBrightness = dot(cloudNormal, vec3(0.05, 0.15, 0.0)) * (0.05 + 0.95 * sunlightPercent) + 0.06 + 0.8 * sunlightPercent;
			float cloudFog = 2.0 - 2.0 * clouds.a;
			color.rgb = mix(color.rgb, vec3(cloudBrightness), 0.6 * cloudFog);
		}
	#endif
	
	
	// rain
	#ifdef OVERWORLD
		vec4 weather = texelFetch(colortex3, ivec2(gl_FragCoord.xy), 0);
		if (weather.a > 0.5) {
			color.rgb = mix(color.rgb, weather.rgb, weather.a);
		}
	#endif
	
	
	// in liquid
	if (isEyeInWater == 1) {
		color *= inWaterTint;
	} else if (isEyeInWater == 2) {
		color *= inLavaTint;
	}
	
	
	// vignette
	#ifdef OVERWORLD
		float maxedPlayerMood = min(playerMood, 1-pow((eyeAltitude+64)/128,2));
		float vignetteScale = pow(1-max(maxedPlayerMood,minVignette),3);
		vec2 vignetteCoords = scaleAroundCenter(texCoords, vec2(0.9, 1.0));
		float vignette = 1-pow(distToCenterSquared(vignetteCoords),0.5);
		vignette = 1.05*vignette*(1-vignetteScale)+vignetteScale;
		color *= vignette;
	#endif
	
	
	#if defined OVERWORLD || defined NETHER
		color = (color - 1) * 0.985 + 1;
	#endif
	
	
	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(dstrt(color, dstrtAmount1, dstrtAmount2, dstrtAmount3), 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	upVec = normalize(gbufferModelView[1].xyz);
}

#endif
