varying vec2 texCoords;
varying float bloomStart;
varying float bloomStep;

uniform sampler2D colortex1;



#ifdef fsh

void main() {
	vec3 color = texelFetch(texture, ivec2(gl_FragCoord / resolutionScale), 0).rgb;
	
	vec3 bloomColor = vec3(0.0);
	float bloomPos = bloomStart;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 0.36787944 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 0.52729242 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 0.69767633 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 0.85214379 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 0.96078944 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 1.00000000 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 0.96078944 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 0.85214379 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 0.69767633 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 0.52729242 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(colortex1, vec2(texCoords.x, bloomPos)).rgb * 0.36787944 / 7.81156284; bloomPos += bloomStep;
	
	float depth = texelFetch(depthtex0, ivec2(gl_FragCoord / resolutionScale), 0).r;
	depth = toLinearDepth(depth);
	depth = mix(near, far, depth);
	#include "/incl/depression.glsl"
	float fogStart = triLerp(min_fogStart, mid_fogStart, max_fogStart, depression);
	float fogDensity = triLerp(min_fogDensity, mid_fogDensity, max_fogDensity, depression);
	float fogAmount = 1.0 - exp(min(fogStart - depth, 0.0) * fogDensity);
	bloomColor *= 1.0 - 0.4 * fogAmount;
	color += bloomColor * bloomAmount * 0.5;
	
	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy / resolutionScale;
	bloomStart = texCoords.y;
	bloomStep = bloomScale / 100.0;
	bloomStart -= bloomStep * 5.0;
}

#endif
