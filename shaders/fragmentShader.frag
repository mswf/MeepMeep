#version 410

uniform sampler2D colorMap;
uniform sampler2D normalMap;
uniform vec3 lightPos;
uniform float time;

//in vec3 T;
//in vec3 B;
in vec3 N;
//in vec3 VertexPositionCameraSpace;
//in vec3 EyeDirectionCameraSpace;
in vec2 uv;

out vec4 Out_Color;

void main()
{
	//mat3 TBN = mat3( T, B, N );

	//vec3 l = lightPos;// - VertexPositionCameraSpace;
	vec3 l = vec3(1);//hardcoded lightpos

	//l *= TBN;
	//l = normalize(l);

	vec3 n = texture( normalMap, uv ).rgb * 2.0 - 1.0 ;
	n = normalize(n);
	//n.y = -n.y;

	float NdotL = max( dot( normalize(N), l ), 0 );

	/*
	float specularCoefficient = 0.0;
	if (NdotL > 0)
	{
		float materialShininess = 2.0;
		vec3 incidenceVector = -l;
		vec3 reflectionVector = reflect(incidenceVector, n); //also a unit vector
		vec3 surfaceToCamera = normalize(EyeDirectionCameraSpace - VertexPositionCameraSpace); //also a unit vector
		float cosAngle = max(0.0, dot(surfaceToCamera, reflectionVector));
		specularCoefficient = pow(cosAngle, materialShininess);
	}
	vec4 specular = vec4( specularCoefficient );
	 */
	vec4 diffuse = vec4( texture( colorMap, uv ).rgb * NdotL, 1.0);
	vec4 finalColor = diffuse;

	Out_Color = finalColor;
	//Out_Color = vec4( n, 1.0); // DEBUGGING NORMALS
}

//float value = sin(time*0.001)*2-1;
//Out_Color = vec4(value, 1.0 - value, 0.0+ value, 1.0);
