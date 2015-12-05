#version 410

layout(location = 0) in vec3 position;

uniform mat4 view;
uniform mat4 projection;

out vec3 texcoords;

void main()
{
	texcoords = position;
	gl_Position = projection * view * vec4( position, 1.0 );
}