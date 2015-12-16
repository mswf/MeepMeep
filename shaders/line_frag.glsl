#version 410

uniform float time;

in vec4 fColour;

layout(location = 0) out vec4 Out_Color;

void main()
{
	Out_Color = fColour;
}