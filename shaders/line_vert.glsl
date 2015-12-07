#version 410

layout(location = 0) in vec3 position;
layout(location = 1) in vec3 colour;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float time;

out vec3 fColour;
// Redeclare gl_Position when using separate shader programs
out vec4 gl_Position;

void main()
{
	fColour = colour;
	gl_Position = projection * view * model * vec4( position, 1.0 );
}
 