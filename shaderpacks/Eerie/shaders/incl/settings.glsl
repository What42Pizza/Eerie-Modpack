// menu options

//#define SHOW_DANGER
#define NIGHT_BRIGHTNESS 0.085 // [0.085 0.15]
#define ENABLE_SCALING
//#define SHADER_TORCHLIGHT

#ifdef ENABLE_SCALING
#endif





// OptiFine options

const bool colortex0MipmapEnabled = true;





// hidden options



#ifdef OVERWORLD

const float normalsSlope = 16.0;

const float min_fogStart = 0.3;
const float avg_fogStart = 0.2;
const float max_fogStart = 0.05;
const float min_fogEnd = 16 * 6;
const float avg_fogEnd = 16 * 5;
const float max_fogEnd = 16 * 4;
const float min_fogCurve = 0.7;
const float avg_fogCurve = 1.2;
const float max_fogCurve = 2.5;

const float targetResolution = 780;
const float resolutionBlobAmount = 0.15;

const float dstrtAmount1 = -0.08;   // saturation
const float dstrtAmount2 = 0.15;   // contrast
const float dstrtAmount3 = -0.28;  // gamma?
const float glColorSaturation = 0.825;
const vec3  glColorTint = vec3(0.94, 0.95, 1.1);

const vec3 blockLight = vec3(1.0, 0.97, 0.93) * 1.0;
const vec3 skyLight = vec3(0.98, 0.99, 1.0) * 1.05;
const float lightMaxSmoothing = 0.025;
const float brightnessCurve = 1.3;
const float lightRainDecreaseAmount = 0.25;

const float minVignette = 0.15;
const vec3 inWaterTint = vec3(0.4, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const float nightVisionBrightness = 0.1;
const vec3 nightVisionTint = vec3(0.0, 1.0, 0.2);
const int sunriseStart = 22800;
const int sunriseEnd = 1500;
const int sunsetStart = 11250;
const int sunsetEnd = 13000;

const float sunPathRotation = 1.2;

#endif



#ifdef NETHER

const float normalsSlope = 12.0;

const float min_fogStart = 0.1;
const float avg_fogStart = 0.1;
const float max_fogStart = 0.1;
const float min_fogEnd = 16 * 8;
const float avg_fogEnd = 16 * 8;
const float max_fogEnd = 16 * 8;
const float min_fogCurve = 2.0;
const float avg_fogCurve = 2.0;
const float max_fogCurve = 2.0;

const float targetResolution = 750;
const float resolutionBlobAmount = 0.2;

const float dstrtAmount1 = -0.05;   // saturation
const float dstrtAmount2 = 0.075;   // contrast
const float dstrtAmount3 = -0.175;  // gamma?
const float glColorSaturation = 0.95;
const vec3  glColorTint = vec3(1);

const vec3 blockLight = vec3(1.0 , 0.45, 0.15) * 1.0;
const float brightnessCurve = 1.5;
const vec3 inWaterTint = vec3(0.5, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const float nightVisionBrightness = 0.08;
const vec3 nightVisionTint = vec3(0.2, 0.4, 0.0);

#endif



#ifdef END

const float normalsSlope = 12.0;

const float min_fogStart = 0.3;
const float avg_fogStart = 0.2;
const float max_fogStart = 0.05;
const float min_fogEnd = 16 * 6;
const float avg_fogEnd = 16 * 5;
const float max_fogEnd = 16 * 4;
const float min_fogCurve = 0.7;
const float avg_fogCurve = 1.2;
const float max_fogCurve = 2.5;

const float targetResolution = 720;
const float resolutionBlobAmount = 0.25;

const float dstrtAmount1 = -0.1;   // saturation
const float dstrtAmount2 = 0.0;   // contrast
const float dstrtAmount3 = -0.3;  // gamma?
const float glColorSaturation = 1.0;
const vec3  glColorTint = vec3(1.0, 1.0, 1.0);

const vec3 blockLight = vec3(1.0, 0.98, 0.95) * 1.2;
const vec3 skyLight = vec3(1.0, 1.0, 1.0) * 0.8;
const float lightMaxSmoothing = 0.02;

const float brightnessCurve = 1.1;
const vec3 inWaterTint = vec3(0.5, 0.5, 1.0);
const vec3 inLavaTint = vec3(1.0, 0.2, 0.2);
const float nightVisionBrightness = 0.0;
const vec3 nightVisionTint = vec3(0.0, 1.0, 0.0);

#endif
