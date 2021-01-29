#version 330 compatibility


uniform float uK;
uniform float uP;



out vec3 vNs;
out vec3 vEs;
out vec3 vMC;


const float Y0 = 1.;

const float PI = 3.14159265;
void
main( )
{
	vMC = gl_Vertex.xyz;
	vec4 newPosition = gl_Vertex;
	
	//pleats here
	float newZ = uK * (Y0-newPosition.y) * sin(2.*PI*newPosition.x/uP);
	newPosition.z = newZ;
	vec4 ECposition = gl_ModelViewMatrix * newPosition;


	float dzdx = uK * (Y0-newPosition.y) * (2.*PI/uP) * cos( 2.*PI*newPosition.x/uP );
	float dzdy = -uK * sin( 2.*PI*newPosition.x/uP );
	vec3 Tx = vec3(1., 0., dzdx );
	vec3 Ty = vec3(0., 1., dzdy );

	vNs = normalize(cross(Tx, Ty));
	 
	vEs = ECposition.xyz - vec3(0.,0.,0.);


	gl_Position = gl_ModelViewProjectionMatrix * newPosition;
	
}