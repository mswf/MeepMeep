#version 330

//uniform Sampler2D Texture;
uniform float time;

//in vec2 Frag_UV;
//in vec4 Frag_Color;
out vec4 Out_Color;

void main()
{
  	//Out_Color = Frag_Color * texture( Texture, Frag_UV.st);
	float value = sin(time*0.001)*2-1;
	Out_Color = vec4(value, 1.0 - value, 0.0+ value, 1.0);
}
