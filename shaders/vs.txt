#version 330

uniform mat4 ProjectionMatrix;
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float time;
in vec3 position;
in vec3 texcoord;
//in vec4 Color;

//out vec2 Frag_UV;
//out vec4 Frag_Color;

void main()
{
	//Frag_UV = UV;
	//Frag_Color = Color;
  	gl_Position = projection * view * model * vec4( position.xyz, 1 );
	//gl_Position = vec4( position.xyz + sin(time)*2-1, 1 );
}
