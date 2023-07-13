#version 460 core

#include <flutter/runtime_effect.glsl>


precision mediump float;

uniform vec3 u_color;
uniform vec2 u_resolution;
out vec4 fragColor;

void main() {
    vec2 st = FlutterFragCoord().xy/u_resolution.x;
    st = st * 2.0 - 1.0;

    float radius = 0.5;
    vec3 color = vec3(0.0);

    float dist = length(st);

    if (dist < radius) {
        color = u_color;
    }

    fragColor = vec4(color, 1.0);
}
