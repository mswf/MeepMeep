#version 410

precision highp float;

uniform sampler2D colorMap;
uniform sampler2D normalMap;
uniform samplerCube cubeMap;
uniform vec3 lightPos;
uniform float time;
uniform vec4 diffuseColor;

subroutine vec3 myMode();
subroutine vec3 shadeModelType( vec3 position, vec3 normal);


subroutine( shadeModelType ) vec3 diffuseOnly( vec3 n, vec3 l )
{
	return vec3(1.0, 1.0, 0.0);
}

subroutine( shadeModelType ) vec3 phongModel( vec3 n, vec3 l )
{
	return vec3(0.0, 1.0, 0.0);
}

subroutine( myMode ) vec3 modeBlue()
{
	return vec3(0.0, 0.0, 1.0);
}

subroutine( myMode ) vec3 modeRed()
{
	return vec3(1.0, 0.0, 0.0);
}

subroutine uniform shadeModelType shadeModel;
subroutine uniform myMode colMode;

struct MaterialInfo
{
	vec4 Ambient;
	vec4 Diffuse;
	vec4 Specular;
	vec4 Emmisive;
	vec4 Transparent;
	vec4 Reflective;
};

struct LightInfo
{
	vec3 position;
	float intensity;
	vec4 color;
};

const int materialCount = 2;
const int lightCount = 4;

layout( std140 ) uniform Material
{
	MaterialInfo materials[materialCount];
};

layout( std140 ) uniform Light
{
	LightInfo lights[lightCount];
};

//in vec3 T;
//in vec3 B;
in vec3 N;
in vec3 VertexPositionCameraSpace;
in vec3 EyeDirectionCameraSpace;
in vec2 uv;

layout(location = 0) out vec4 FragColor;

float diffuse( vec3 n, vec3 l )
{
	return max( dot( n, l ), 0 );
}

float specular( vec3 eye, vec3 pos, vec3 n, vec3 l )
{
	float materialShininess = 2.0;
	vec3 incidenceVector = -l;
	vec3 reflectionVector = reflect(incidenceVector, n); //also a unit vector
	vec3 surfaceToCamera = normalize(EyeDirectionCameraSpace - VertexPositionCameraSpace); //also a unit vector
	float cosAngle = max(0.0, dot(surfaceToCamera, reflectionVector));
	return pow(cosAngle, materialShininess);
}

vec3 viewLight( vec3 lP, vec3 vP, mat3 TBN )
{
	return normalize( ( lightPos - VertexPositionCameraSpace ) * TBN );
}

void main()
{	
	vec3 l = normalize( lightPos - VertexPositionCameraSpace ); // viewLight( lightPos, VertexPositionCameraSpace, TBN );
	
	//vec3 n = texture( normalMap, uv ).rgb * 2.0 - 1.0 ;
	vec3 n = N;
	n = normalize(n);
	//n.y = -n.y;
	
	vec3 model = shadeModel( n,l );
	vec3 m = colMode();
	
	float lambert = diffuse(n,l);
	float specularCoefficient = 0.0;
	
	if (lambert > 0)
	{
		specularCoefficient = specular( EyeDirectionCameraSpace, VertexPositionCameraSpace, n, l );
	}
	
	vec4 specular = vec4( vec3(specularCoefficient), 1 );
	
	FragColor = vec4( texture( colorMap, uv ).rgb, 1) * diffuseColor;// * texture( cubeMap, reflect (-VertexPositionCameraSpace, n) );
	//FragColor = vec4( n, 1.0); // DEBUGGING NORMALS
}