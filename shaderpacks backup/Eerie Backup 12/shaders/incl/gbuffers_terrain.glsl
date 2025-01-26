varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 color;
varying float normalShading;



#ifdef fsh

uniform sampler2D texture;
uniform sampler2D lightmap;

/* DRAWBUFFERS:0 */
void main() {
	vec4 albedo = texture2D(texture, texCoords) * color;
	vec2 lightmap = texture2D(lightmap, lmCoords).xy;
	#ifdef OVERWORLD
		vec3 lightmapShading = max(blockLight * lightmap.x, skyLight * lightmap.y);
	#endif
	#ifdef NETHER
		vec3 lightmapShading = blockLight * lightmap.x;
	#endif
	albedo.rgb *= lightmapShading * vec3(normalShading);
	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = gl_MultiTexCoord0.st;
	lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	color = gl_Color;
	vec3 separateNormals = (gl_Normal + normalsSlope-1) / normalsSlope;
	normalShading = separateNormals.r * 0.75 + separateNormals.g * 0.15 + separateNormals.b * 0.1;
}

#endif