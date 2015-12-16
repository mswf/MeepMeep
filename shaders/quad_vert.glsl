#version 410

layout(location = 0) in vec3 position;
layout(location = 1) in vec2 uvs;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

out vec2 texcoords;

void main()
{
	texcoords = uvs;
	gl_Position = projection * view * model * vec4( position, 1.0 );
}