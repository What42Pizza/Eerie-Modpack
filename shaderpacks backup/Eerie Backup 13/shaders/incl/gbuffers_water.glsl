in vec3 mc_Entity;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying float isWater;



#ifdef fsh

uniform sampler2D lightmap;
uniform sampler2D texture;

/* DRAWBUFFERS:04 */
void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);

	gl_FragData[0] = color;
	gl_FragData[1] = vec4(isWater, 0.0, 0.0, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;

	isWater = (mc_Entity.x == 10008.0) ? 1.0 : 0.0;

	glcolor = gl_Color;
}

#endif