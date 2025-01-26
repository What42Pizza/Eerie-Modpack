#version 120

varying vec2 texCoords;
varying vec2 lmCoords;
varying vec4 color;
varying float normalShading;

uniform sampler2D texture;
uniform sampler2D lightmap;

const vec3 torchColor = vec3(1.0, 0.925, 0.925) * 1.1;
const vec3 skyColor   = vec3(1.0, 0.99 , 0.98 );

/* DRAWBUFFERS:0 */
void main(){
    vec4 albedo = texture2D(texture, texCoords) * color;
    vec2 lightmap = texture2D(lightmap, lmCoords).xy;
    vec3 lightmapShading = max(torchColor * lightmap.x, skyColor * lightmap.y);
    albedo.rgb *= lightmapShading * vec3(normalShading);
    gl_FragData[0] = albedo;
}