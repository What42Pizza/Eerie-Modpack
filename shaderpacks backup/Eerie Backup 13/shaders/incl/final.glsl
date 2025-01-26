varying vec2 texcoord;



#ifdef fsh

uniform sampler2D gcolor;
uniform sampler2D gaux1; // isWater
uniform float eyeAltitude;
uniform int isEyeInWater;

/* DRAWBUFFERS:0 */
void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;


	// in liquid
	if (isEyeInWater == 1) {
		color *= inWaterTint;
	} else if (isEyeInWater == 2) {
		color *= inLavaTint;
	}


	gl_FragData[0] = vec4(dstrt(color, dstrtAmount), 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();

	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}

#endif