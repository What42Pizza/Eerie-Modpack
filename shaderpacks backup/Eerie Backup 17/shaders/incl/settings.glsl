#ifdef OVERWORLD

const float dstrtAmount = 0.02;
const float fogStart = 0.35;
const float fogCurveMult = -0.5;
const float normalsSlope = 16.0;
const float horizonAltitudeMult = 0.3;

//const vec3 blockLight = vec3(1.0 , 0.98, 0.975) * 1.2;
//const vec3 skyLight = vec3(0.95, 0.96, 1.0) * 1.1;
const vec3 blockLight = vec3(1.0 , 1.0, 1.0) * 1.2;
const vec3 skyLight = vec3(0.965, 0.975, 1.0) * 1.1;
const float brightnessCurve = 1.1;
const vec3 inWaterTint = vec3(0.425, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const vec3 nightVisionTint = vec3(0.5, 0.8, 0.7);
const int sunriseStart = 22500;
const int sunriseEnd = 1500;
const int sunsetStart = 11250;
const int sunsetEnd = 13250;

const float sunPathRotation = 0.75;

#endif



#ifdef NETHER

const float dstrtAmount = 0.05;
const float fogStart = 0.5;
const float fogCurveMult = -1.0;
const float normalsSlope = 20.0;

const vec3 blockLight = vec3(1.0 , 0.8, 0.8) * 1.0;
const float brightnessCurve = 1.1;
const vec3 inWaterTint = vec3(0.5, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const vec3 nightVisionTint = vec3(0.5, 0.8, 0.7);

#endif



#ifdef END

const float dstrtAmount = 0.05;
const float normalsSlope = 16.0;

const vec3 blockLight = vec3(1.0 , 0.95, 0.95) * 1.0;
const vec3 skyLight = vec3(1.0, 1.0, 1.0) * 1.0;
const float brightnessCurve = 1.1;
const vec3 inWaterTint = vec3(0.5, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const vec3 nightVisionTint = vec3(0.5, 0.8, 0.7);

#endif
