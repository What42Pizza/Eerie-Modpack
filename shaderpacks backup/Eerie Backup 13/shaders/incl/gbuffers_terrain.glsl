varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 biomeColor;
varying float normalShading;



#ifdef fsh

uniform sampler2D texture;
uniform sampler2D lightmap;

/* DRAWBUFFERS:0 */
void main() {
	vec4 color = texture2D(texture, texCoords) * biomeColor;
	vec3 skyColor = getSkyColor();


/*
	// fog
	#ifdef OVERWORLD
		float depth_raw = getDepth(texcoord);
		float depth = (depth_raw > SKY_DEPTH) ? 0 : depth_raw;
		depth = (depth-fogStart)/(1-fogStart);
		depth += sin(2*PI*depth)*fogCurveMult/10;
		depth = clamp(depth, 0.0, 1.0);

		vec3 outsideColor = mix(color.xyz, skyColor, depth);
		vec3 caveColor = mix(color.xyz, vec3(0, 0, 0), depth_raw);
		float caveLerpAmount = clamp((eyeAltitude-caveFogTransitionLow)/(caveFogTransitionHigh-caveFogTransitionLow), 0, 1);
		color = mix(caveColor, outsideColor, caveLerpAmount);
	#endif
	#ifdef NETHER
		float depth = getDepth(texcoord);
		depth = (depth-fogStart)/(1-fogStart);
		depth += sin(2*PI*depth)*fogCurveMult/10;
		depth = clamp(depth, 0.0, 1.0);
		color = mix(color, skyColor, depth);
	#endif
*/


	// shading
	#ifdef OVERWORLD
		vec3 lightmapShading = max(blockLight * lmCoords.x, skyLight * lmCoords.y);
	#elif defined NETHER
		vec3 lightmapShading = blockLight * lightmap.x;
	#else
		vec3 lightmapShading = vec3(max(lightmap.x, lightmap.y));
	#endif
	color.rgb *= lightmapShading * vec3(normalShading);


	gl_FragData[0] = color;
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = gl_MultiTexCoord0.st;
	lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	biomeColor = gl_Color;
	vec3 separateNormals = (gl_Normal + normalsSlope-1) / normalsSlope;
	normalShading = separateNormals.r * 0.75 + separateNormals.g * 0.15 + separateNormals.b * 0.1;
}

#endif