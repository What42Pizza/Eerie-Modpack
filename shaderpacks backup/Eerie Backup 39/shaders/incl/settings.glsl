// menu options

//#define SHOW_DANGER
#define ENABLE_SCALING

#ifdef ENABLE_SCALING
#endif





// OptiFine options

const bool colortex0MipmapEnabled = true;





// hidden options



const float resolutionScale = 0.75;
const float resolutionBlobAmount = 0.15;
const int   resolutionBlobLOD = 2;

const float normalsSlope = 12.0;
const float moodZoomAmount = 0.15;

const float fogClipping = 16 * 5;
const float min_fogStart = 0.4;
const float min_fogCurve = 0.5;  // higher means closer
const float min_fogMin = 0.01;
const float avg_fogStart = 0.3;
const float avg_fogCurve = 1.5;  // higher means closer
const float avg_fogMin = 0.01;
const float max_fogStart = 0.0;
const float max_fogCurve = 3.0;  // higher means closer
const float max_fogMin = 0.05;



#ifdef OVERWORLD

const float dstrtAmount1 = -0.03;   // saturation
const float dstrtAmount2 = 0.075;   // contrast
const float dstrtAmount3 = -0.175;  // gamma?

const vec3 blockLight = vec3(1.0, 0.98, 0.95) * 1.05;
//const vec3 skyLight = vec3(0.98, 0.99, 1.0) * 1.1;
const vec3 skyLight = vec3(0.99, 0.995, 1.0) * 1.1;
const float lightMaxSmoothing = 0.02;
const float brightnessCurve = 1.3;
const float lightDecreaseAmount = 0.8; // decreases based on height and time of day (whichever is lower)
const float lightDecreaseMinY = 16;
const float lightDecreaseMaxY = 64;
const float lightRainDecreaseAmount = 0.25;

const float minVignette = 0.15;
const vec3 inWaterTint = vec3(0.4, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const vec3 nightVisionTint = vec3(0.5, 0.8, 0.7);
const int sunriseStart = 22750;
const int sunriseEnd = 1500;
const int sunsetStart = 11250;
const int sunsetEnd = 13200;

const float sunPathRotation = 1.25;

#endif



#ifdef NETHER

const float dstrtAmount1 = -0.05;   // saturation
const float dstrtAmount2 = 0.075;   // contrast
const float dstrtAmount3 = -0.175;  // gamma?
const float fogStart = 0.3;
const float fogCurve = 1.5;  // higher means closer

const vec3 blockLight = vec3(1.0 , 0.8, 0.8) * 1.0;
const float brightnessCurve = 1.1;
const vec3 inWaterTint = vec3(0.5, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const vec3 nightVisionTint = vec3(0.5, 0.8, 0.7);

#endif



#ifdef END

const float dstrtAmount1 = -0.05;   // saturation
const float dstrtAmount2 = 0.1;   // contrast
const float dstrtAmount3 = -0.1;  // gamma?
const float fogStart = 0.3;
const float fogCurve = 1.5;  // higher means closer

const vec3 blockLight = vec3(1.0, 0.98, 0.95) * 1.05;
const vec3 skyLight = vec3(1.0, 1.0, 1.0) * 0.9;
const float lightMaxSmoothing = 0.02;

const float brightnessCurve = 1.1;
const vec3 inWaterTint = vec3(0.5, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const vec3 nightVisionTint = vec3(0.5, 0.8, 0.7);

#endif
