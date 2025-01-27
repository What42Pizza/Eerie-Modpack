varying vec4 glColor;
varying vec3 upVec;





#ifdef fsh

void main() {
	vec3 skyColor = getSkyColor();
	
	float horizonMultiplier = getHorizonMultiplier(gl_FragCoord.z, upVec);
	skyColor *= horizonMultiplier;
	
	/* DRAWBUFFERS:1 */
	gl_FragData[0] = vec4(skyColor, 1.0);
}

#endif





#ifdef vsh

void main() {
	gl_Position = ftransform();
	glColor = gl_Color;
	upVec = normalize(gbufferModelView[1].xyz);
}

#endif
