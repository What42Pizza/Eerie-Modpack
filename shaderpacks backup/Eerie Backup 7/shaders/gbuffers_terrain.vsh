#version 120

const float normalsSlope = 20.0;

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

void main() {
    gl_Position = ftransform();
    TexCoords = gl_MultiTexCoord0.st;
    LightmapCoords = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st;
    LightmapCoords = (LightmapCoords * 33.0 / 32.0) - (1.0 / 32.0);
    vec3 separateNormals = (gl_Normal + normalsSlope-1) / normalsSlope;
    Normal = vec3(separateNormals.r * 0.75 + separateNormals.g * 0.15 + separateNormals.b * 0.1, 0.0, 0.0);
    Color = gl_Color;
}