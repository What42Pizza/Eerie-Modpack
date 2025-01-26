varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 glColor;
varying float normalShading;
varying float isWater;



#ifdef fsh

uniform sampler2D texture;
uniform float nightVision;
uniform vec4 entityColor;

/* DRAWBUFFERS:04 */
void main() {
	vec4 albedo = texture2D(texture, texCoords) * glColor;

	#ifdef OVERWORLD
		vec3 lightmapShading = max(blockLight * lmCoords.x, skyLight * lmCoords.y);
	#elif defined NETHER
		vec3 lightmapShading = blockLight * lmCoords.x;
	#elif defined END
		vec3 lightmapShading = max(blockLight * lmCoords.x, skyLight * lmCoords.y);
	#endif
	albedo.rgb *= lightmapShading * normalShading * pow(nightVisionTint, vec3(pow(nightVision, 0.3)));
	albedo.rgb = mix(albedo.rgb, entityColor.rgb, entityColor.a);

	gl_FragData[0] = albedo;
	gl_FragData[1] = vec4(isWater, 0.0, 0.0, 1.0);
}

#endif



#ifdef vsh

in vec3 mc_Entity;
uniform float nightVision;

void main() {
	gl_Position = ftransform();
	texCoords = gl_MultiTexCoord0.st;

	#ifdef OVERWORLD
		lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
		lmCoords.y *= getSunlightPercent();
	#elif defined NETHER
		lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	#elif defined END
		lmCoords.x = (gl_TextureMatrix[1] * gl_MultiTexCoord1).x;
		lmCoords.y = 0.65;
	#endif

	lmCoords.xy = max(lmCoords.xy, vec2(pow(nightVision, 0.5)));

	glColor = vec4(dstrt(gl_Color.rgb, -0.025), gl_Color.a);

	isWater = (mc_Entity.x == 10008.0) ? 1.0 : 0.0;

	vec3 separateNormals = (gl_Normal + normalsSlope-1) / normalsSlope;
	normalShading = separateNormals.r * 0.75 + separateNormals.g * 0.15 + separateNormals.b * 0.1;

}

#endif