//flag shader
//status alpha

float4x4 wvp : WORLDVIEWPROJECTION;
float t : TIME;
texture flag0;
texture noise0;

float amplitudePower=1.5;
float waveSpeed=2;
float waves=1;

sampler2D flagSampler=sampler_state{
	Texture=<flag0>;
};

sampler2D noiseSampler=sampler_state{
	Texture=<noise0>;
};


struct vs_input{
		float4 position 	:	POSITION;
		float2 TexCoord 	: 	TEXCOORD0;
};

struct ps_input{
		float4 position 	:	POSITION;
		float2 TexCoord 	: 	TEXCOORD0;
		float sp		:	TEXCOORD1;
};

ps_input mainVS(vs_input In){
	ps_input Out; 		
	Out.TexCoord=In.TexCoord;
	float height=sin(t*waveSpeed-(In.position.y+In.position.x/5)*3.141*waves/8)*amplitudePower;
	float height2=sin(t*waveSpeed/2-(In.position.y)*3.141*waves/8)*amplitudePower;
	Out.position=mul(float4(In.position.x+height2/5,In.position.y,height,1),wvp);
	Out.sp=1+height/2;
    return Out;
} 

float4 mainPS(ps_input In) : COLOR{
	float4 color=tex2D(flagSampler,In.TexCoord);
	float4 noise=tex2D(noiseSampler,float2(In.TexCoord.x,In.TexCoord.y+t/40));	
	return color*noise*In.sp;
}

technique FLAG{
    pass P0{	
		VertexShader = compile vs_2_0 mainVS();	
		CullMode = NONE;
        PixelShader = compile ps_2_0 mainPS();
    }
}
 