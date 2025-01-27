varying vec2 texCoords;
varying vec3 normal;
varying float depth;



#ifdef fsh

void main() {
	if (texture2D(texture, texCoords).a < 0.5) discard;
	
	vec4 albedo = vec4(normal * 0.5 + 0.5, 0.5 + 0.5 * depth);
	
	/* DRAWBUFFERS:2 */
	gl_FragData[0] = albedo;
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = gl_MultiTexCoord0.st;
	vec4 worldPos = gbufferModelViewInverse * gbufferProjectionInverse * gl_Position;
	worldPos.xyz /= worldPos.w;
	depth = min(length(worldPos.xz) / 16 / 16, 1.0);
	normal = gl_Normal;
}

#endif
