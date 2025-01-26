varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 glColor;
varying float normalShading;



#ifdef fsh

uniform sampler2D texture;
uniform float nightVision;
uniform vec4 entityColor;

/* DRAWBUFFERS:0 */
void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;

	#ifdef NETHER
		vec3 lightmapShading = blockLight * lmCoords.x;
	#else
		vec3 lightmapShading = max(blockLight * lmCoords.x, skyLight * lmCoords.y);
	#endif
	albedo.rgb = mix(albedo.rgb, entityColor.rgb, entityColor.a);
	albedo.rgb *= lightmapShading * normalShading * pow(nightVisionTint, vec3(pow(nightVision, 0.3)));

	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

uniform float nightVision;

void main() {
	gl_Position = ftransform();
	texCoords = gl_MultiTexCoord0.st;
	lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;

	#ifdef OVERWORLD
		lmCoords.y *= getSunlightPercent();
		lmCoords = adjustBrightness (lmCoords);
	#elif defined NETHER
		lmCoords = adjustBrightness (lmCoords);
	#elif defined END
		lmCoords.y = 0.65;
	#endif

	lmCoords.xy = max(lmCoords.xy, vec2(pow(nightVision, 0.5)));

	glColor = gl_Color;

	vec3 separateNormals = (gl_Normal + normalsSlope-1) / normalsSlope;
	normalShading = separateNormals.r * 0.75 + separateNormals.g * 0.15 + separateNormals.b * 0.1;

}

#endif