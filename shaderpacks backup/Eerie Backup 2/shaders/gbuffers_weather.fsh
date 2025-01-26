#version 120

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;

/* DRAWBUFFERS:0 */
void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;

	gl_FragData[0] = color; //gcolor
}