#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 R;
uniform float iTime;
uniform sampler2D uTexture;

out vec4 fragColor;




float stepfun(float x) {
    return (sign(x) + 1.0) / 2.0;
}

float square(vec2 pos) {
    return (stepfun(pos.x + 1.5) * stepfun(1.5 - pos.x)) *
    (stepfun(pos.y + 1.5) * stepfun(1.5 - pos.y));
}

vec2 dist(vec2 pos)
{
    vec2 offset = pos + vec2(cos(iTime * 1.0) / 80.0,
    sin(iTime * 1.0) / 80.0);

    return pos + square((offset - 0.5) * 5.0) *
    texture(uTexture, (offset - 0.5) * 5.0).xy * 0.05;
}

void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = FlutterFragCoord() / R.xy;

    // Output to screen
    fragColor = texture(uTexture, dist(uv));
}