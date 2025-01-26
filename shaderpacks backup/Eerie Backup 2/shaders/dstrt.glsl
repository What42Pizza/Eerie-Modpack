#define PI 3.1415926538

vec3 dstrt(vec3 v, float a){return mix(vec3(0.5,0.5,0.5),v-sin(2*PI*(v-dot(v,vec3(0.2125,0.7154,0.0721))))*a,1+a/2);}

/*
	float color_lum = dot(color, vec3(0.2125, 0.7154, 0.0721));
	vec3 lum_diff = color - color_lum;
	lum_diff = lum_diff - sin(2 * PI * lum_diff) * a;
	color = color_lum + lum_diff;
	color = mix(vec3(0.5, 0.5, 0.5), color, 1 + a/2);
*/