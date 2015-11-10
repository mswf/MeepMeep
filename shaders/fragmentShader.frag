#version 410

uniform sampler2D tex;
uniform float time;

in vec2 uv;
//in vec4 Frag_Color;
in vec3 Frag_Normal;

out vec4 Out_Color;

void main()
{
	vec3 l = normalize( vec3(1.0) );
	vec3 n = normalize( Frag_Normal );
	
	float diff = max( dot( l, n ), 0 );
	//vec3 intensity = vec3( diff,diff,diff );
	vec4 mapColor = texture( tex, uv.st );
	
	
	
	float value = sin(time*0.001)*2-1;
	Out_Color = vec4(value, 1.0 - value, 0.0+ value, 1.0);
	//Out_Color = vec4(intensity, 1.0);
	Out_Color = vec4(uv.st, 0.0, 1.0);
	Out_Color = vec4(mapColor.rgb * diff, 1.0);
}
