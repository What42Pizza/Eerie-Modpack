varying vec4 glColor;



#ifdef fsh

/* DRAWBUFFERS:05 */
void main() {
	vec3 skyColor = getSkyColor();
	float horizon = getHorizonMultiplier();
	skyColor *= horizon;

	if (glColor.r == glColor.g && glColor.g == glColor.b && glColor.r > 0.0) {
		skyColor = glColor.rgb;
	}

	gl_FragData[0] = vec4(skyColor, 1.0);
	gl_FragData[1] = vec4(horizon, 0.0, 0.0, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	glColor = gl_Color;
	upVec = normalize(gbufferModelView[1].xyz);
}

#endif