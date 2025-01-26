#define PI 3.1415926538

uniform sampler2D depthtex0;
uniform float viewHeight;
uniform float viewWidth;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelView;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform float near;
uniform float far;

vec3 dstrt(vec3 v, float a){return mix(vec3(0.5,0.5,0.5),v-sin(2*PI*(v-dot(v,vec3(0.2125,0.7154,0.0721))))*a,1+a/2);}

/*
	float color_lum = dot(color, vec3(0.2125, 0.7154, 0.0721));
	vec3 lum_diff = color - color_lum;
	lum_diff = lum_diff - sin(2 * PI * lum_diff) * a;
	color = color_lum + lum_diff;
	color = mix(vec3(0.5, 0.5, 0.5), color, 1 + a/2);
*/

vec3 calcSkyColor() {
	vec4 pos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight) * 2.0 - 1.0, 1.0, 1.0) * gbufferProjectionInverse;
	float upDot = max(dot(normalize(pos.xyz), gbufferModelView[1].xyz), 0.0);
	float fogAmount = 0.25 / (upDot*upDot + 0.25);
	return mix(dstrt(skyColor, 0.1), dstrt(fogColor, 0.01), fogAmount);
}

float getDepth(vec2 coord) {
    return 2.0 * near * far / (far + near - (2.0 * texture2D(depthtex0, coord).x - 1.0) * (far - near)) / (far/1.75);
}