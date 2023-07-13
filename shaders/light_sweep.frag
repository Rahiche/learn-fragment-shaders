#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float iTime;
uniform sampler2D uTexture;

out vec4 fragColor;

void main()
{
	vec2 r = FlutterFragCoord().xy / uSize.xy;

	float col = sin(r.y + r.x*2. -iTime*3.) * .9;
    col *= col * col * .5;

    col = clamp(col, 0., 1.);

    vec4 tex = texture(uTexture, r);

    fragColor = tex + vec4(col);
}