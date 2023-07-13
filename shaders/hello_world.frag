

#version 460 core

precision mediump float;

uniform vec3 u_color;
out vec4 fragColor;

void main() {
    fragColor = vec4(u_color, 1.0);
}


