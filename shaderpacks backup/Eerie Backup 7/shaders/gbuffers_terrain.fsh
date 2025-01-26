#version 120

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

uniform sampler2D texture;

/* DRAWBUFFERS:012 */
void main(){
    vec4 Albedo = texture2D(texture, TexCoords) * Color;
    gl_FragData[0] = Albedo;
    gl_FragData[1] = vec4(Normal, 1.0);
    gl_FragData[2] = vec4(LightmapCoords, 0.0f, 1.0f);
}