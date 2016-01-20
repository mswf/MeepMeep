#version 410

in vec2 texcoords;
//uniform sampler2D colorMap;
layout(location = 0) out vec4 FragColour;

void main()
{
	FragColour = vec4(1,0,0,1); //texture( colorMap, texcoords );
}
