#define PI (3.1415926538)

uniform float viewHeight;
uniform float viewWidth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform float near;
uniform float far;
uniform int worldTime;
uniform int worldDay;
uniform float eyeAltitude;
uniform int isEyeInWater;
uniform float playerMood;
uniform float nightVision;
uniform vec4 entityColor;
uniform float rainStrength;
uniform float fogEnd;
uniform vec3 cameraPosition;
uniform int heldBlockLightValue;

uniform sampler2D texture;
uniform sampler2D depthtex0;

#ifdef fsh
	#define FLAT flat in
#else
	#define FLAT flat out
#endif



/*
DON'T REMOVE
const int colortex2Format = RGBA16F;
const int colortex3Format = RGBA16F;
*/

float resolutionScale = targetResolution / viewHeight;





float getColorLum(vec3 color) {
	return dot(color, vec3(0.2125, 0.7154, 0.0721));
}

float percentThrough(float a, float b, float c) {
	return (a - b) / (c - b);
}

vec2 scaleAroundCenter(vec2 coords, vec2 scale) {
	return (coords - 0.5) * scale + 0.5;
}

float triLerp(float v1, float v2, float v3, float a) {
	if (a < 0.5) {
		return mix(v1, v2, a * 2.0);
	} else {
		return mix(v2, v3, a * 2.0 - 1.0);
	}
}

vec3 smoothMin(vec3 a, vec3 b, float c) {
	float aLum = getColorLum(a);
	float bLum = getColorLum(b);
	return (a + b - sqrt((a - b) * (a - b) + c * (aLum + bLum) / 2)) / 2;
}

vec3 smoothMax(vec3 a, vec3 b, float c) {
	float aLum = getColorLum(a);
	float bLum = getColorLum(b);
	return (a + b + sqrt((a - b) * (a - b) + c * (aLum + bLum) / 2)) / 2;
}

float maxDiff(vec3 a, vec3 b) {
	vec3 diff = abs(a - b);
	return max(max(diff.x, diff.y), diff.z);
}

float distToCenterSquared(vec2 coords) {
	vec2 centralized = coords * 2 - 1;
	float x = centralized.x;
	float y = centralized.y;
	return (x*x + y*y) / 2;
}

float toLinearDepth(float depth) {
	return 2.0 * near / (far + near - depth * (far - near));
}

float fromLinearDepth(float depth) {
	return (2.0 * near / depth - far - near) / (near - far);
}

vec3 screenToView(vec3 pos) {
	vec4 iProjDiag = vec4(
		gbufferProjectionInverse[0].x,
		gbufferProjectionInverse[1].y,
		gbufferProjectionInverse[2].zw
	);
	vec3 p3 = pos * 2.0 - 1.0;
	vec4 viewPos = iProjDiag * p3.xyzz + gbufferProjectionInverse[3];
	return viewPos.xyz / viewPos.w;
}



#ifdef FSH
	uint rngStart =
		uint(gl_FragCoord.x) +
		uint(gl_FragCoord.y) * uint(viewWidth) +
		uint(frameCounter  ) * uint(viewWidth) * uint(viewHeight);
#endif

float randomFloat(inout uint rng) {
	rng = rng * 747796405u + 2891336453u;
	uint v = ((rng >> ((rng >> 28u) + 4u)) ^ rng) * 277803737u;
	v = (v >> 22u) ^ v;
	float f = float(v % 1000000u);
	return f / 1000000.0;
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

vec3 rgb2hsv(vec3 c) {
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
	vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}



vec2 adjustBrightness(vec2 lmCoords) {
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
	float sunlight;
	if (worldTime > 6000 && worldTime < 18000) {
		sunlight = getSunlightPercent_Sunset();
	} else {
		sunlight = getSunlightPercent_Sunrise();
	}
	return pow(sunlight, 1.5);
}

#endif



#ifdef fsh

vec3 getSkyColor() {
	#ifdef OVERWORLD
		#include "/incl/depression.glsl"
		vec4 pos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight) * 2.0 - 1.0, 1.0, 1.0) * gbufferProjectionInverse;
		float upDot = max(dot(normalize(pos.xyz), gbufferModelView[1].xyz), 0.0);
		float fogAmount = 0.1 / (upDot * upDot + 0.1);
		vec3 sky = dstrt(skyColor * 0.9, mix(-0.15, -0.4, depression), 0.0, -0.2);
		vec3 fog = dstrt(fogColor * getSunlightPercent(), mix(-0.1, -0.5, depression), 0.0, -0.5);
		return mix(sky, fog, fogAmount * 0.5);
	#elif defined NETHER
		return vec3(0.0);
	#elif defined END
		return vec3(0.0);
	#endif
}

float getHorizonMultiplier(float depth, vec3 upVec) {
	#ifdef OVERWORLD
		vec2 coords = gl_FragCoord.xy / vec2(viewWidth, viewHeight);
		vec4 screenPos = vec4(coords, depth, 1.0);
		vec4 viewPos = gbufferProjectionInverse * (screenPos * 2.0 - 1.0);
		float viewDot = dot(normalize(viewPos.xyz), upVec); // normalize() negates the need for `/= w`
		float altitudeAddend = atan (75/(eyeAltitude - 59));
		altitudeAddend += (altitudeAddend > 0) ? -PI/2 : PI/2; // fix output of atan
		altitudeAddend -= (atan(eyeAltitude-64)+PI/2)/20; // shrink horizon faster when you're high off the ground
		return clamp(viewDot*2.5 - altitudeAddend*8, 0.0, 1.0);
	#else
		return 1;
	#endif
}

#endif
