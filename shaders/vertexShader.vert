#version 410

layout(location = 0) in vec3 position;
layout(location = 1) in vec3 normal;
layout(location = 2) in vec2 texcoord;

uniform mat4 ProjectionMatrix;
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float time;
//in vec4 Color;

out vec2 uv;
//out vec4 Frag_Color;
out vec3 Frag_Normal;

void main()
{
	uv = texcoord;
	//Frag_Color = Color;
	gl_PointSize = 10.0;
	Frag_Normal = normalize( vec3(view * model * vec4( normal, 0.0 ) ) );
  	gl_Position = projection * view * model * vec4( position, 1.0 );
	//gl_Position = vec4( position.xyz + sin(time)*2-1, 1 );
}
