


//to 1d functions

//get a scalar random value from a 3d value
float rand3dTo1d(vec3 value, vec3 dotDir){

	//make value smaller to avoid artefacts
	vec3 smallValue = sin(value);
	//get scalar value from 3d vector
	float random = dot(smallValue, dotDir);
	//make value more random by making it bigger and then taking the factional part
	random = fract(sin(random) * 143758.5453);
	return random;
}

float rand2dTo1d(vec2 value, vec2 dotDir){
	vec2 smallValue = sin(value);
	float random = dot(smallValue, dotDir);
	random = fract(sin(random) * 143758.5453);
	return random;
}

float rand1dTo1d(float value, float mutator){
	float random = fract(sin(value + mutator) * 143758.5453);
	return random;
}

//to 2d functions

vec2 rand3dTo2d(vec3 value){
	return vec2(
		rand3dTo1d(value, vec3(12.989, 78.233, 37.719)),
		rand3dTo1d(value, vec3(39.346, 11.135, 83.155))
	);
}

vec2 rand2dTo2d(vec2 value){
	return vec2(
		rand2dTo1d(value, vec2(12.989, 78.233)),
		rand2dTo1d(value, vec2(39.346, 11.135))
	);
}

vec2 rand1dTo2d(float value){
	return vec2(
		rand1dTo1d(value, 3.9812),
		rand1dTo1d(value, 7.1536)
	);
}

//to 3d functions

vec3 rand3dTo3d(vec3 value){
	return vec3(
		rand3dTo1d(value, vec3(12.989, 78.233, 37.719)),
		rand3dTo1d(value, vec3(39.346, 11.135, 83.155)),
		rand3dTo1d(value, vec3(73.156, 52.235, 09.151))
	);
}

vec3 rand2dTo3d(vec2 value){
	return vec3(
		rand2dTo1d(value, vec2(12.989, 78.233)),
		rand2dTo1d(value, vec2(39.346, 11.135)),
		rand2dTo1d(value, vec2(73.156, 52.235))
	);
}

vec3 rand1dTo3d(float value){
	return vec3(
		rand1dTo1d(value, 3.9812),
		rand1dTo1d(value, 7.1536),
		rand1dTo1d(value, 5.7241)
	);
}

float easeIn(float interpolator){
			return interpolator * interpolator;
		}

		float easeOut(float interpolator){
			return 1 - easeIn(1 - interpolator);
		}

		float easeInOut(float interpolator){
			float easeInValue = easeIn(interpolator);
			float easeOutValue = easeOut(interpolator);
			return mix(easeInValue, easeOutValue, interpolator);
		}

		float perlinNoise(vec3 value){
			vec3 fraction = fract(value);

			float interpolatorX = easeInOut(fraction.x);
			float interpolatorY = easeInOut(fraction.y);
			float interpolatorZ = easeInOut(fraction.z);

			float cellNoiseZ[2];
			for(int z=0;z<=1;z++){
				float cellNoiseY[2];
				for(int y=0;y<=1;y++){
					float cellNoiseX[2];
					for(int x=0;x<=1;x++){
						vec3 cell = floor(value) + vec3(x, y, z);
						vec3 cellDirection = rand3dTo3d(cell) * 2 - 1;
						vec3 compareVector = fraction - vec3(x, y, z);
						cellNoiseX[x] = dot(cellDirection, compareVector);
					}
					cellNoiseY[y] = mix(cellNoiseX[0], cellNoiseX[1], interpolatorX);
				}
				cellNoiseZ[z] = mix(cellNoiseY[0], cellNoiseY[1], interpolatorY);
			}
			float noise = mix(cellNoiseZ[0], cellNoiseZ[1], interpolatorZ);
			return noise;
		}

// define some varying vectors that are useful for writing custom fragment shaders
varying vec4 worldPosition;
varying vec4 viewPosition;
varying vec4 screenPosition;
varying vec3 vertexNormal;
varying vec4 vertexColor;


#ifdef PIXEL
    vec4 effect(vec4 color, Image tex, vec2 texcoord, vec2 pixcoord)
    {
        vec4 texcolor = Texel(tex, vec2(texcoord.x, texcoord.y));
        if (texcolor.a == 0.0) { discard; }

        float thingy = fract(worldPosition.z/40.0);

        //return vec4(texcolor)*color*vertexColor;
        return vec4(0,thingy,0.1,1);
    }
#endif