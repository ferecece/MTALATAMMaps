//
// file: material3DCom.fx
// version: v1.5
// author: Ren712
//

//--------------------------------------------------------------------------------------
// Settings
//--------------------------------------------------------------------------------------
float3 sElementPosition = float3(0,0,0);
float3 sElementRotation = float3(0,0,0);
float2 sScrRes = float2(800,600);
float2 sElementSize = float2(1,1);
bool sFlipTexture = false;
bool sFlipVertex = false;
bool sIsBillboard = false;
bool sFogEnable = false;

bool fZEnable = true;
bool fZWriteEnable = true;
int fCullMode = 1;
int fDestBlend = 5;

float fDepthBias = 1;
float2 gDistFade = float2(250,150);
bool bIsCorona = false;

float2 uvMul = float2(1,1);
float2 uvPos = float2(0,0);

//--------------------------------------------------------------------------------------
// Textures
//--------------------------------------------------------------------------------------
texture sTexColor;

//--------------------------------------------------------------------------------------
// Variables set by MTA
//--------------------------------------------------------------------------------------
float4x4 gProjection : PROJECTION;
float4x4 gView : VIEW;
float3 gCameraPosition : CAMERAPOSITION;
int CUSTOMFLAGS < string skipUnusedParameters = "yes"; >;

//--------------------------------------------------------------------------------------
// Sampler 
//--------------------------------------------------------------------------------------
sampler2D SamplerColor = sampler_state
{
    Texture = (sTexColor);
    AddressU = Mirror;
    AddressV = Mirror;
};

//--------------------------------------------------------------------------------------
// Structures
//--------------------------------------------------------------------------------------
struct VSInput
{
    float3 Position : POSITION0;
    float2 TexCoord : TEXCOORD0;
    float4 Diffuse : COLOR0;
};

struct PSInput
{
    float4 Position : POSITION0;
    float2 TexCoord : TEXCOORD0;
    float DistFactor : TEXCOORD1;
    float DistFade : TEXCOORD2;
    float4 Diffuse : COLOR0;
};

//--------------------------------------------------------------------------------------
// Create world matrix with world position and euler rotation
//--------------------------------------------------------------------------------------
float4x4 createWorldMatrix(float3 pos, float3 rot)
{
    float4x4 eleMatrix = {
        float4(cos(rot.z) * cos(rot.y) - sin(rot.z) * sin(rot.x) * sin(rot.y), 
                cos(rot.y) * sin(rot.z) + cos(rot.z) * sin(rot.x) * sin(rot.y), -cos(rot.x) * sin(rot.y), 0),
        float4(-cos(rot.x) * sin(rot.z), cos(rot.z) * cos(rot.x), sin(rot.x), 0),
        float4(cos(rot.z) * sin(rot.y) + cos(rot.y) * sin(rot.z) * sin(rot.x), sin(rot.z) * sin(rot.y) - 
                cos(rot.z) * cos(rot.y) * sin(rot.x), cos(rot.x) * cos(rot.y), 0),
        float4(pos.x,pos.y,pos.z, 1),
    };
	return eleMatrix;
}

//--------------------------------------------------------------------------------------
// MTAUnlerp
//--------------------------------------------------------------------------------------
float MTAUnlerp( float from, float to, float pos )
{
    if ( from == to )
        return 1.0;
    else
        return ( pos - from ) / ( to - from );
}

//--------------------------------------------------------------------------------------
// Vertex Shader 
//--------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;
	
    // set proper position and scale of the quad
    VS.Position.xyz -= sElementPosition;
    VS.Position.xyz = VS.Position.xzy;
    VS.Position.xy *= sElementSize.xy;
	
    if (!sFlipTexture) VS.TexCoord.x = 1 - VS.TexCoord.x;
	
    if ((sFlipVertex) && (!sIsBillboard)) VS.Position.xyz = VS.Position.xzy;

    // create WorldMatrix for the quad
    float4x4 sWorld = createWorldMatrix(sElementPosition, sElementRotation);

    // calculate screen position of the vertex
    if (sIsBillboard) 
    {
        float4x4 sWorldView = mul(sWorld, gView);
        float3 vPos = VS.Position.xyz + sWorldView[3].xyz;
		
        vPos.xyz += fDepthBias * 1.5 * mul( normalize(gCameraPosition - sElementPosition), gView).xyz;
	
	
        PS.Position = mul(float4(vPos, 1), gProjection);
    }
    else
    {
        float4 wPos = mul(float4(VS.Position, 1), sWorld);
        float4 vPos = mul(wPos, gView); 
        PS.Position = mul(vPos, gProjection);
    }
	
    float DistFromCam = distance( gCameraPosition, sElementPosition.xyz );
    PS.DistFade = MTAUnlerp ( gDistFade[0], gDistFade[1], DistFromCam );
    DistFromCam /= fDepthBias;
    PS.DistFactor = saturate( DistFromCam * 0.5 - 1.6 );	

    // pass texCoords and vertex color to PS
    PS.TexCoord = (VS.TexCoord * uvMul) + uvPos;
    PS.Diffuse = VS.Diffuse;
	
    return PS;
}

//--------------------------------------------------------------------------------------
// Pixel shaders 
//--------------------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    // sample color texture
    float4 finalColor = tex2D(SamplerColor, PS.TexCoord.xy);
	
    if (bIsCorona)
    {
        // Set for corona
        finalColor.rgb = pow( finalColor.rgb * 1.2, 1.5 );
        finalColor *= PS.Diffuse;
        finalColor.a *= PS.DistFactor;
        finalColor.a *= saturate( PS.DistFade );
    }
    else
	{
        // multiply by vertex color
        finalColor *= PS.Diffuse;
    }

    return saturate(finalColor);
}

//--------------------------------------------------------------------------------------
// Techniques
//--------------------------------------------------------------------------------------
technique dxDrawMaterial3DCom
{
  pass P0
  {
    ZEnable = fZEnable;
    ZWriteEnable = fZWriteEnable;
    CullMode = fCullMode;
    ShadeMode = Gouraud;
    AlphaBlendEnable = true;
    SrcBlend = SrcAlpha;
    DestBlend = fDestBlend;
    AlphaTestEnable = true;
    AlphaRef = 1;
    AlphaFunc = GreaterEqual;
    Lighting = false;
    FogEnable = sFogEnable;
    VertexShader = compile vs_2_0 VertexShaderFunction();
    PixelShader  = compile ps_2_0 PixelShaderFunction();
  }
} 
	