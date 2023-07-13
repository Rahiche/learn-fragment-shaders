#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;
uniform vec2 iMouse;
uniform sampler2D uSampler;

out vec4 fragColor;


const float radius=0.2;
const float depth=radius/2.;

// Inspired by https://www.shadertoy.com/view/4tdXDl.
void main()
{
    vec2 uv = FlutterFragCoord().xy/iResolution.xy;
    vec2 center = iMouse.xy/iResolution.xy;
    float ax = ((uv.x - center.x) * (uv.x - center.x)) / (0.2*0.2) + ((uv.y - center.y) * (uv.y - center.y)) / (0.2/ (  iResolution.x / iResolution.y )) ;
    float dx = 0.0 + (-depth/radius)*ax + (depth/(radius*radius))*ax*ax;
    float f =  (ax + dx );
    if (ax > radius) f = ax;
    vec2 magnifierArea = center + (uv-center)*f/ax;
    fragColor = vec4(texture( uSampler, vec2(1,-1) * magnifierArea ).rgb, 1.);
}