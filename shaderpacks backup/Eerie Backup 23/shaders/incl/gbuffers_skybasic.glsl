varying vec4 glColor;



#ifdef fsh

/* DRAWBUFFERS:05 */
void main() {
	vec3 baseColor = getSkyColor();
	vec3 skyColor = baseColor.rgb;

	if (glColor.r == glColor.g && glColor.g == glColor.b && glColor.r > 0.0) {
		skyColor = glColor.rgb;
	}

	float horizon = getHorizonMultiplier();
	baseColor *= horizon;
	skyColor *= horizon;

	gl_FragData[0] = vec4(skyColor, 1.0);
	gl_FragData[1] = vec4(baseColor, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	glColor = gl_Color;
	upVec = normalize(gbufferModelView[1].xyz);
}

#endif