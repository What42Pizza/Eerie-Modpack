varying vec4 starData; //rgb = star color, a = flag for weather or not this pixel is a star.



#ifdef fsh

/* DRAWBUFFERS:0 */
void main() {
	vec3 color;
	if (starData.a > 0.5) {
		color = starData.rgb;
	} else {
		//vec4 pos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight) * 2.0 - 1.0, 1.0, 1.0);
		//pos = gbufferProjectionInverse * pos;
		color = getSkyColor();
	}

	gl_FragData[0] = vec4(color, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	starData = vec4(gl_Color.rgb, float(gl_Color.r == gl_Color.g && gl_Color.g == gl_Color.b && gl_Color.r > 0.0));
}

#endif