
#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>


uniform vec2 iResolution;
uniform float iTime;
uniform sampler2D uTexture;

out vec4 fragColor;

void main(  ) {
    vec2 p1 = vec2(.01, .01);
    vec2 p2 = vec2(.99, .99);
    vec2 p3 = vec2(.01, .99);
    vec2 p4 = vec2(.99, .01);

    vec2 uv = FlutterFragCoord().xy / iResolution.xy;
    vec4 c2 = texture(uTexture, uv + iTime/10.);

    float d1 = step(p1.x,uv.x)*step(uv.x,p4.x)*abs(uv.y-p1.y)+
    step(uv.x,p1.x)*distance(uv,p1)+step(p4.x,uv.x)*distance(uv,p4);
    d1 = min(step(p3.x,uv.x)*step(uv.x,p2.x)*abs(uv.y-p2.y)+
    step(uv.x,p3.x)*distance(uv,p3)+step(p2.x,uv.x)*distance(uv,p2),d1);
    d1 = min(step(p1.y,uv.y)*step(uv.y,p3.y)*abs(uv.x-p1.x)+
    step(uv.y,p1.y)*distance(uv,p1)+step(p3.y,uv.y)*distance(uv,p3),d1);
    d1 = min(step(p4.y,uv.y)*step(uv.y,p2.y)*abs(uv.x-p2.x)+
    step(uv.y,p4.y)*distance(uv,p4)+step(p2.y,uv.y)*distance(uv,p2),d1);

    float f1 = .01 / abs(d1 + c2.r/100.);

    fragColor = vec4(f1 * vec3(0.1, 0.6, 0.8), 1.0);
}