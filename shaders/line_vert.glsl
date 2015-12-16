#version 410

layout(location = 0) in vec3 position;
layout(location = 1) in vec4 colour;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float time;
uniform float pointSize;

out vec4 fColour;
// Redeclare gl_Position when using separate shader programs
out vec4 gl_Position;

void main()
{
	// float value = sin( time * 2.0f ) + 1 * 5.0;
	// vec3 modifier = vec3( value, value, value);
	gl_PointSize = pointSize;
	// fColour = colour * modifier;
	fColour = colour;
	gl_Position = projection * view * model * vec4( position, 1.0 );
}
