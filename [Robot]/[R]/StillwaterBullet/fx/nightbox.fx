//
// nightbox.fx
//

float gFogEnd < string renderState="FOGEND"; >;
float gTime : TIME;
float3 gCameraPosition : CAMERAPOSITION;
float4x4 gWorld : WORLD;
float4x4 gWorldViewProjection : WORLDVIEWPROJECTION;

texture sSkyBoxTexture;

float3 gRotate = float3(0,0,0);
bool gAnimate = false;
int fCullMode = 2;

//---------------------------------------------------------------------
//-- Sampler for the main texture (needed for pixel shaders)
//---------------------------------------------------------------------

samplerCUBE envMapSampler1 = sampler_state
{
    Texture = (sSkyBoxTexture);
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU  = Wrap;
    AddressV  = Wrap;
    MIPMAPLODBIAS = 0.000000;
};

//---------------------------------------------------------------------
//-- Structure of data sent to the vertex shader
//--------------------------------------------------------------------- 
 
 struct VSInput
{
    float4 Position : POSITION; 
    float3 TexCoord : TEXCOORD0;
    float3 Normal : NORMAL0;
};

//---------------------------------------------------------------------
//-- Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------

struct PSInput
{
    float4 Position : POSITION; 
    float3 TexCoord : TEXCOORD0;	
};

//-----------------------------------------------------------------------------
//-- Euler rotate
//-----------------------------------------------------------------------------
float3x3 eulRotate(float3 Rotate, bool Anim)
{
    float cosX,sinX;
    float cosY,sinY;
    float cosZ,sinZ;

    float time = 1;
    if (Anim) {time = gTime;}
	
    sincos(Rotate.x * time,sinX,cosX);
    sincos(-Rotate.y * time,sinY,cosY);
    sincos(Rotate.z * time,sinZ,cosZ);

//Euler extrinsic rotations 
//http://www.vectoralgebra.info/eulermatrix.html


		float3x3 rot = float3x3(
		cosY * cosZ + sinX * sinY * sinZ, -cosX * sinZ,  sinX * cosY * sinZ - sinY * cosZ,
		cosY * sinZ - sinX * sinY * cosZ,  cosX * cosZ, -sinY * sinZ - sinX * cosY * cosZ,
		cosX * sinY,                       sinX,         cosX * cosY
	);

return rot;	
}

//-----------------------------------------------------------------------------
//-- VertexShader
//-----------------------------------------------------------------------------
PSInput VertexShaderSB(VSInput VS)
{
    PSInput PS = (PSInput)0;
 
    // Position in screen space.
    VS.Position.xyz *= float3(1, 1, 1) * gFogEnd * 0.324;
    PS.Position = mul(VS.Position, gWorldViewProjection);
    // compute the 4x4 tranform from tangent space to object space
    float4 worldPos = mul(VS.Position, gWorld);
    // compute the eye vector 
	
    float3 eyeVector = worldPos.xyz - gCameraPosition;
	PS.TexCoord.xzy = mul(eulRotate( gRotate, gAnimate), eyeVector.xyz);
    return PS;
}

//-----------------------------------------------------------------------------
//-- PixelShader
//-----------------------------------------------------------------------------
float4 PixelShaderSB(PSInput PS) : COLOR0
{
    float3 eyevec = normalize(PS.TexCoord.xyz);
    float4 outPut = texCUBE(envMapSampler1, eyevec);
    outPut.rgb = pow(outPut.rgb,1.1);
    outPut.rgb -= 0.1;
    return saturate(outPut);
}


//-----------------------------------------------------------------------------
//-- Technique
//-----------------------------------------------------------------------------
technique SkyBox
{
    pass P0
    {
        FogEnable = false;
        CullMode = fCullMode;
        VertexShader = compile vs_2_0 VertexShaderSB();
        PixelShader = compile ps_2_0 PixelShaderSB();
    }
}
