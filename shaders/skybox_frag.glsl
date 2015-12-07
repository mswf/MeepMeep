#version 410

in vec3 texcoords;
uniform samplerCube cube_texture;
layout(location = 0) out vec4 FragColour;

void main()
{
	FragColour = texture( cube_texture, texcoords );
}
