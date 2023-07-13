#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;
uniform float iTime;


// Copyright (C) 2015 Matthew Ready
// Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia license.
// http://creativecommons.org/licenses/by-nc-sa/3.0/au

#define N_POPS 5
#define TIME_BETWEEN_POPS 1.2
#define TIME_BETWEEN_POPS_RANDOM 0.6
#define N_CONFETTI 16
#define PI 3.1415926535
#define SQUARE_HARDNESS 10.0
#define GLOW_INTENSITY 0.8
#define HUE_VARIANCE 0.2

#define V_INITIAL 600.0
#define V_RANDOM 300.0
#define GRAVITY 17.81
#define TERMINAL_VELOCITY 60.0
#define TERMINAL_VELOCITY_RANDOM 10.0

#define GLOW_WHITENESS 0.56
#define SQUARE_WHITENESS 0.86



out vec4 fragColor;


// From my other shader https://www.shadertoy.com/view/4tB3zD
float trapezium(float x)
{
    //            __________
    // 1.0 -     /          \
    //          /            \                .
    // 0.5 -   /              \              .  --> Repeating
    //        /                \            .
    // 0.0 - /                  \__________/
    //
    //       |    |    |    |    |    |    |
    //      0.0  1/6  2/6  3/6  4/6  5/6  6/6
    //
    return min(1.0, max(0.0, 1.0 - abs(-mod(x, 1.0) * 3.0 + 1.0)) * 2.0);
}

vec3 colFromHue(float hue)
{
    // https://en.wikipedia.org/wiki/Hue#/media/File:HSV-RGB-comparison.svg
    return vec3(trapezium(hue - 1.0/3.0), trapezium(hue), trapezium(hue + 1.0/3.0));
}

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

// Gets a random value for the most recent explosion at the specified time.
float getPopRandom(float time, float random) {
    time = floor(time / TIME_BETWEEN_POPS);
    return rand(vec2(time, random));
}

// Gets a random value for the most recent explosion at the specified time.
float getPopTime(float time) {
    float pop_start_time = floor(time / TIME_BETWEEN_POPS) * TIME_BETWEEN_POPS
    + (getPopRandom(time, 2.2)) * TIME_BETWEEN_POPS_RANDOM;
    return iTime - pop_start_time;
}

float xposition(float time, float angle, float v_initial, float terminal_v) {
    float g = GRAVITY;
    float v = v_initial;
    float t = time;
    float sin_amp = 20.0 * (1.0 - exp(-pow(time / 7.0, 2.0)));
    float x_t = sin(time / 5.0) * sin_amp + time * 3.0;
    return v * terminal_v / g * (1.0 - exp(-g*t/terminal_v)) * cos(angle) + x_t;
}

float yposition(float time, float angle, float v_initial, float terminal_v) {
    float g = GRAVITY;
    float v = v_initial;
    float t = time;
    return v * terminal_v / g * (1.0 - exp(-g*t/terminal_v)) * sin(angle) - terminal_v * t;
}

// This function from http://www.blackpawn.com/texts/pointinpoly/
// Own modifications added.
float isInExtendedTriangle(vec2 b, vec2 a, vec2 c, vec2 p)
{
    // Compute vectors
    vec2 v0 = c - a;
    vec2 v1 = b - a;
    vec2 v2 = p - a;

    // Compute dot products
    float dot00 = dot(v0, v0);
    float dot01 = dot(v0, v1);
    float dot02 = dot(v0, v2);
    float dot11 = dot(v1, v1);
    float dot12 = dot(v1, v2);

    // Compute barycentric coordinates
    float denom = (dot00 * dot11 - dot01 * dot01);
    if (denom < 0.001) {
        return 0.0;
    }
    float invDenom = 1.0 / denom;
    float u = (dot11 * dot02 - dot01 * dot12) * invDenom;
    float v = (dot00 * dot12 - dot01 * dot02) * invDenom;

    // Check if point is in triangle
    return clamp(u * SQUARE_HARDNESS, 0.0, 1.0) *
    clamp(v * SQUARE_HARDNESS, 0.0, 1.0);// *
    //  clamp((1.0 - (u + v)) * 100.0, 0.0, 1.0); // (u >= 0) && (v >= 0) && (u + v < 1)
}

float isInQuad(vec2 a, vec2 b, vec2 c, vec2 d, vec2 p)
{
    return isInExtendedTriangle(a, b, c, p) * isInExtendedTriangle(c, d, a, p);
}

vec4 rotate(float phi, float theta, float psi) {
    float cosPhi = cos(phi), sinPhi = sin(phi);
    float cosTheta = cos(theta), sinTheta = sin(theta);
    float cosPsi = cos(psi), sinPsi = sin(psi);
    mat3 matrix;

    vec3 row0 = vec3(cosTheta * cosPsi, -cosTheta * sinPsi, sinTheta);

    vec3 row1 = vec3(cosPhi * sinPsi + sinPhi * sinTheta * cosPsi,
    cosPhi * cosPsi - sinPhi * sinTheta * sinPsi,
    -sinPhi * cosTheta);

    vec3 a = row0 - row1;

    vec3 b = row0 + row1;

    return vec4(a, b);
}

float isInRotatedQuad(vec4 offsets, vec2 center, vec2 p)
{
    return isInQuad(center + offsets.xy,
    center + offsets.zw,
    center - offsets.xy,
    center - offsets.zw, p);
}

void main(  ) {
    vec2 scaledFragCoord = FlutterFragCoord() / iResolution.xy * vec2(20.0, 20.0);
//    vec2 scaledFragCoord = FlutterFragCoord() / vec2(10, 10) * vec2(800.0, 450.0);
    const float size = 6.0;
    const float max_square_dist = size * size * 128.0;
    float max_dist = sqrt(max_square_dist);
    const float confettiRotateTimeScale = 2.0;

    float t = iTime * confettiRotateTimeScale / 5.0 + 1.3;
    vec4 matrix1 = rotate(t * 8.0, sin(t) * 0.5, t / 4.0) * size;
    t = iTime * confettiRotateTimeScale / 5.1 + 92.2;
    vec4 matrix2 = rotate(t * 8.0, sin(t) * 0.5, t / 4.0) * size;
    t = iTime * confettiRotateTimeScale / 5.5 + 7.1;
    vec4 matrix3 = rotate(t * 8.0, sin(t) * 0.5, t / 4.0) * size;
    t = iTime * confettiRotateTimeScale / 4.3 + 1.0;
    vec4 matrix4 = rotate(t * 8.0, sin(t) * 0.5, t / 4.0) * size;

    vec4 col = vec4(0.0, 0.0, 0.0, 0.0);
    for (int i=0; i<N_POPS; i++) {
        float sampleTime = iTime - float(i) * TIME_BETWEEN_POPS;
        float popTime = getPopTime(sampleTime);
        vec2 point = vec2(getPopRandom(sampleTime, 3.1) * 800.0, 0);
        float baseHue = getPopRandom(sampleTime, 3.5);

        if (abs(scaledFragCoord.x - point.x) > 300.0) {
            continue;
        }


        for (int j=0; j<N_CONFETTI; j++) {
            float angle = PI / 2.0 + PI / 4.0 * (getPopRandom(sampleTime, float(j)) - 0.5);
            float v_initial =  V_INITIAL + V_RANDOM * getPopRandom(sampleTime, float(j - 5));
            float terminal_v = TERMINAL_VELOCITY + TERMINAL_VELOCITY_RANDOM * (getPopRandom(sampleTime, float(j - 10)) - 0.5);

            float alterTime = popTime * 10.0;
            float x = xposition(alterTime, angle, v_initial, terminal_v) / 5.0;
            float y = yposition(alterTime, angle, v_initial, terminal_v) / 5.0;

            vec2 confettiLocation = vec2(point.x + x, y);
            vec2 delta = confettiLocation - scaledFragCoord;
            float dist = dot(delta, delta);
            if (dist > max_square_dist) {
                continue;
            }
            //dist = sqrt(dist);
            float glowIntensity = (clamp(1.0 - pow(dist / max_square_dist, 0.05), 0.0, 1.0) / 1.0) * GLOW_INTENSITY;
            float f = getPopRandom(sampleTime, float(j - 2));
            vec4 matrix;
            float matrixIndex = mod(f * 4.0, 4.0);
            if (matrixIndex < 1.0) {
                matrix = matrix1;
            } else if (matrixIndex < 2.0) {
                matrix = matrix2;
            } else if (matrixIndex < 3.0) {
                matrix = matrix3;
            } else {
                matrix = matrix4;
            }
            float squareIntensity = isInRotatedQuad(matrix,
            confettiLocation,
            scaledFragCoord);
            vec3 pastelColour = colFromHue(baseHue + getPopRandom(sampleTime, float(j - 15)) * HUE_VARIANCE);
            vec3 pastelGlowColour = glowIntensity * (pastelColour * (1.0 - GLOW_WHITENESS) + vec3(GLOW_WHITENESS, GLOW_WHITENESS, GLOW_WHITENESS));
            vec3 pastelSqColour = squareIntensity * (pastelColour * (1.0 - SQUARE_WHITENESS) + vec3(SQUARE_WHITENESS, SQUARE_WHITENESS, SQUARE_WHITENESS));
            col += vec4(pastelGlowColour + pastelSqColour, 0.0);
        }
    }
    col.a = 1.0;

    fragColor = col;
}