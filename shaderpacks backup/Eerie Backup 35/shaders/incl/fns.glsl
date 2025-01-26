#define PI (3.1415926538)
#define SKY_DEPTH (1.749)
#ifdef OVERWORLD
	#define CLIPPING (far/1.75)
#elif defined NETHER
	#define CLIPPING (far/2.0)
#elif defined END
	#define CLIPPING (far)
#endif

uniform sampler2D depthtex0;
uniform float viewHeight;
uniform float viewWidth;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelView;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform float near;
uniform float far;
uniform int worldTime;
varying vec3 upVec;
uniform float eyeAltitude;





float getColorLum (vec3 color) {
	return dot(color, vec3(0.2125, 0.7154, 0.0721));
}

float average (vec3 v) {
	return (v.x + v.y + v.z) / 3.0;
}

float percentThrough (float a, float b, float c) {
	return (a - b) / (c - b);
}

vec2 scaleAroundCenter (vec2 coords, vec2 scale) {
	return (coords - 0.5) * scale + 0.5;
}

vec3 smoothMin (vec3 a, vec3 b, float c) {
	float aLum = getColorLum(a);
	float bLum = getColorLum(b);
	return (a + b - sqrt((a - b) * (a - b) + c * (aLum + bLum) / 2)) / 2;
}

vec3 smoothMax (vec3 a, vec3 b, float c) {
	float aLum = getColorLum(a);
	float bLum = getColorLum(b);
	return (a + b + sqrt((a - b) * (a - b) + c * (aLum + bLum) / 2)) / 2;
}

float distToCenterSqaured (vec2 coords) {
	vec2 centralized = coords * 2 - 1;
	float x = centralized.x;
	float y = centralized.y;
	return (x*x + y*y) / 2;
}



vec3 dstrt(vec3 color, float a, float b, float c) {
	float color_lum = getColorLum(color);
	vec3 lum_diff = color - color_lum;
	//lum_diff = lum_diff - sin(2 * PI * lum_diff) * -a;
	lum_diff = pow(abs(lum_diff), vec3(1 - a)) * sign(lum_diff);
	color = color_lum + lum_diff;
	color = mix(vec3(0.25, 0.25, 0.25), color, 1 + b);
	color = pow(color, vec3(1 + c));
	return color;
}



vec2 adjustBrightness (vec2 lmCoords) {
	lmCoords -= 0.03126; // moves darkest values to black (value found through trial and error)
	return 1-pow(1-lmCoords,vec2(brightnessCurve));
}



#ifdef OVERWORLD

float getSunlightPercent_Sunrise() {
	int time = (worldTime > 12000) ? (worldTime - 24000) : worldTime;
	return clamp(percentThrough(time, sunriseStart - 24000, sunriseEnd), 0.0, 1.0);
}

float getSunlightPercent_Sunset() {
	int time = worldTime;
	return clamp(1-percentThrough(time, sunsetStart, sunsetEnd), 0.0, 1.0);
}

float getSunlightPercent() {
	if (worldTime > 6000 && worldTime < 18000) {
		return getSunlightPercent_Sunset();
	}
	return getSunlightPercent_Sunrise();
}

#endif



#ifdef fsh

vec3 getSkyColor() {
	#ifdef OVERWORLD
		vec4 pos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight) * 2.0 - 1.0, 1.0, 1.0) * gbufferProjectionInverse;
		float upDot = max(dot(normalize(pos.xyz), gbufferModelView[1].xyz), 0.0);
		float fogAmount = 0.25 / (upDot*upDot + 0.25);
		return mix(dstrt(skyColor, -0.15, 0.0, -0.5), dstrt(fogColor * getSunlightPercent(), -0.15, 0.0, -0.3), fogAmount * 0.66);
	#elif defined NETHER
		return vec3(0.121, 0.017, 0.017);
	#elif defined END
		return vec3(0.0, 0.0, 0.0);
	#endif
}

float getDepth(vec2 coords) {
	return 2.0 * near * far / (far + near - (2.0 * texture2D(depthtex0, coords).x - 1.0) * (far - near)) / CLIPPING;
}

#endif