#version 410

in vec2 texcoords;
uniform sampler2D colorMap;
layout(location = 0) out vec4 FragColour;

void main()
{
	FragColour = texture( colorMap, texcoords );
}
