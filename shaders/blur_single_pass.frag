#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform sampler2D uTexture;


out vec4 fragColor;
void main( ) {
    float Pi = 6.28318530718; // Pi*2

    // GAUSSIAN BLUR SETTINGS {{{
    float Directions = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
    float Quality = 3.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
    float Size = 8.0; // BLUR SIZE (Radius)
    // GAUSSIAN BLUR SETTINGS }}}

    vec2 Radius = Size/FlutterFragCoord().xy;

    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (FlutterFragCoord()- uSize.xy) / uSize.y;

    // Pixel colour
    vec4 Color = texture(uTexture, uv);

//     Blur calculations
    for( float d=0.0; d<Pi; d+=Pi/Directions)
    {
        for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
        {
            Color += texture(uTexture, uv+vec2(cos(d),sin(d))*Radius*i);
        }
    }

//     Output to screen
    Color /= Quality * Directions - 15.0;
    fragColor = Color;
}