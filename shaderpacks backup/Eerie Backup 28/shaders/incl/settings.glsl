// menu options

//#define SHOW_DANGER



// hidden options

#ifdef OVERWORLD

//const float dstrtAmount1 = 0.01;
//const float dstrtAmount2 = 0.05;
//const float dstrtAmount1 = -0.02;
//const float dstrtAmount2 = 0.05;
//const float dstrtAmount1 = 0.01;
//const float dstrtAmount2 = 0.006;
//const float dstrtAmount3 = -0.15;
const float dstrtAmount1 = -0.05;
const float dstrtAmount2 = 0.075;
const float dstrtAmount3 = -0.175;
const float fogStart = 0.3;
const float fogCurveMult = -0.5;
const float normalsSlope = 12.0;

const vec3 blockLight = vec3(1.0 , 1.0, 1.0) * 1.25;
const vec3 skyLight = vec3(0.965, 0.975, 1.0) * 1.15;
const float brightnessCurve = 1.1;
const vec3 inWaterTint = vec3(0.4, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const vec3 nightVisionTint = vec3(0.5, 0.8, 0.7);
const int sunriseStart = 22750;
const int sunriseEnd = 1500;
const int sunsetStart = 11250;
const int sunsetEnd = 13250;

const float sunPathRotation = 0.75;

#endif



#ifdef NETHER

const float dstrtAmount1 = 0.5;
const float dstrtAmount2 = 0.5;
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

const float dstrtAmount1 = 0.05;
const float dstrtAmount2 = 0.05;
const float normalsSlope = 16.0;

const vec3 blockLight = vec3(1.0 , 0.95, 0.95) * 1.0;
const vec3 skyLight = vec3(1.0, 1.0, 1.0) * 1.0;
const float brightnessCurve = 1.1;
const vec3 inWaterTint = vec3(0.5, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const vec3 nightVisionTint = vec3(0.5, 0.8, 0.7);

#endif
