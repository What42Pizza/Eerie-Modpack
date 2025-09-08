varying vec2 texCoords;
varying float bloomStart;
varying float bloomStep;



#ifdef fsh

void main() {
	
	vec3 bloomColor = vec3(0.0);
	float bloomPos = bloomStart;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 0.36787944 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 0.52729242 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 0.69767633 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 0.85214379 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 0.96078944 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 1.00000000 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 0.96078944 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 0.85214379 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 0.69767633 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 0.52729242 / 7.81156284; bloomPos += bloomStep;
	bloomColor += texture2D(texture, vec2(bloomPos, texCoords.y)).rgb * 0.36787944 / 7.81156284; bloomPos += bloomStep;
	
	/* DRAWBUFFERS:1 */
	gl_FragData[0] = vec4(bloomColor, 1.0);
}

#endif



#ifdef vsh

void main() {
	gl_Position = ftransform();
	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	bloomStart = texCoords.x;
	bloomStep = bloomScale / 100.0 * viewHeight / viewWidth;
	bloomStart -= bloomStep * 5.0;
}

#endif
