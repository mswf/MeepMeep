#version 410

layout(location = 0) in vec3 position;
layout(location = 1) in vec2 uvs;

out vec2 texcoords;

void main()
{
	texcoords = uvs;
	gl_Position = vec4( position, 1.0 );
}