#version 410

uniform float time;

in vec3 fColour;

layout(location = 0) out vec4 Out_Color;

void main()
{
	Out_Color = vec4( fColour, 1.0 );
}