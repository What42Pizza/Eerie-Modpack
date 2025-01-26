#ifdef OVERWORLD

const float dstrtAmount = 0.02;
const float caveFogTransitionLow = 60;
const float caveFogTransitionHigh = 63;
const float fogStart = 0.25;
const float fogCurveMult = -1.5;
const vec3 inWaterTint = vec3(0.5, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const vec3 blockLight = vec3(1.0 , 0.925, 0.925) * 1.1;
const vec3 skyLight = vec3(0.99, 0.99, 1.0);
const float normalsSlope = 20.0;

const float sunPathRotation = 0.75;

#endif



#ifdef NETHER

const float dstrtAmount = 0.05;
const float fogStart = 0.5;
const float fogCurveMult = -1.0;
const vec3 inWaterTint = vec3(0.5, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const vec3 blockLight = vec3(1.0 , 0.8, 0.8) * 1.0;
const float normalsSlope = 20.0;

#endif
