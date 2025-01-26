#version 120

const float normalsSlope = 16.0;

varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 color;
varying float normalShading;

void main() {
    gl_Position = ftransform();
    texCoords = gl_MultiTexCoord0.st;
    lmCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    color = gl_Color;
    vec3 separateNormals = (gl_Normal + normalsSlope-1) / normalsSlope;
    normalShading = separateNormals.r * 0.75 + separateNormals.g * 0.15 + separateNormals.b * 0.1;
}