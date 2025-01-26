varying vec4 glColor;



float getHorizonMultiplier() {
	#ifdef OVERWORLD
		vec4 screenPos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight), gl_FragCoord.z, 1.0);
		vec4 viewPos = gbufferProjectionInverse * (screenPos * 2.0 - 1.0);
		//viewPos /= viewPos.w; // not needed?
		float viewDot = dot(normalize(viewPos.xyz), upVec);
		float altitudeAddend = atan (75/(eyeAltitude - 64));
		altitudeAddend += (altitudeAddend > 0) ? -PI/2 : PI/2; // fix output of atan
		altitudeAddend -= (atan(eyeAltitude-64)+PI/2)/20; // shrink horizon faster when you're high off the ground
		return clamp(viewDot*5 - altitudeAddend*8, 0.0, 1.0);
	#else
		return 1;
	#endif
}





#ifdef fsh

/* DRAWBUFFERS:05 */
void main() {
	vec3 skyColor = getSkyColor();

	if (glColor.r == glColor.g && glColor.g == glColor.b && glColor.r > 0.0) {
		skyColor = glColor.rgb;
	}

	float horizonMultiplier = getHorizonMultiplier();
	skyColor *= horizonMultiplier;

	gl_FragData[0] = vec4(skyColor, 1.0);
	gl_FragData[1] = vec4(horizonMultiplier, 0.0, 0.0, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	glColor = gl_Color;
	upVec = normalize(gbufferModelView[1].xyz);
}

#endif