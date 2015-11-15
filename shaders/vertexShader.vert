#version 410

layout(location = 0) in vec3 position;
layout(location = 1) in vec3 normal;
layout(location = 2) in vec2 texcoord;
layout(location = 3) in vec3 tangent;
layout(location = 4) in vec3 bitangent;

uniform mat4 model;
uniform mat4 view;
uniform mat3 mvMatrix;
uniform mat3 normalMatrix;
uniform mat4 projection;
uniform float time;

//out vec3 T;
//out vec3 B;
//out vec3 N;
//out vec3 VertexPositionCameraSpace;
//out vec3 EyeDirectionCameraSpace;
out vec2 uv;

void main()
{
	//T = normalize( normalMatrix * tangent );
	//B = normalize( normalMatrix * bitangent );
	//N = normalize( normalMatrix * normal );
	//VertexPositionCameraSpace = vec3( mvMatrix * position );
	//EyeDirectionCameraSpace = normalize( -VertexPositionCameraSpace );

	uv = texcoord;
	gl_Position = projection * view * model * vec4( position, 1.0 );
}
