#version 120

varying vec2 TexCoords;

uniform vec3 sunPosition;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;

uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

const vec3 torchColor = vec3(1.0, 0.925, 0.925) * 1.1;
const vec3 SkyColor   = vec3(1.0, 0.99 , 0.98 );

vec3 GetLightmapColor (in vec2 Lightmap) {
    return Lightmap.x * torchColor + Lightmap.y;
}

/* DRAWBUFFERS:0 */
void main() {
    vec3 Albedo = texture2D(colortex0, TexCoords).rgb;
    float Depth = texture2D(depthtex0, TexCoords).r;
    if (Depth == 1.0f) {
        gl_FragData[0] = vec4(Albedo, 1.0f);
        return;
    }
    float Normal = texture2D(colortex1, TexCoords).r;
    vec2 Lightmap = texture2D(colortex2, TexCoords).rg;
    vec3 LightmapColor = GetLightmapColor(Lightmap);
    vec3 Diffuse = Albedo * LightmapColor * Normal;
    gl_FragData[0] = vec4(Diffuse, 1.0f);
}