//
// file: primitive3D_ring_ap.fx
// version: v1.5
// author: Ren712
//

//--------------------------------------------------------------------------------------
// Settings
//--------------------------------------------------------------------------------------
float3 sElementPosition = float3(0, 0, 0);
float3 sElementRotation = float3(0, 0, 0);
float4 sElementColor = float4(0, 0, 0, 0);
float3 sElementSize = float3(1,1,1);
float2 sElementShape = float2(0.8,0.7);

bool sFlipTexture = false;
bool sFlipVertex = false;
bool sIsBillboard = false;

float2 gDistFade = float2(250, 150);
float fDestBlend = 6;

float2 uvMul = float2(1, 1);
float2 uvPos = float2(0, 0);

//--------------------------------------------------------------------------------------
// Variables set by MTA
//--------------------------------------------------------------------------------------
float4x4 gWorldViewProjection : WORLDVIEWPROJECTION;
float4x4 gProjection : PROJECTION;
float4x4 gView : VIEW;
float4x4 gViewInverse : VIEWINVERSE;
float3 gCameraPosition : CAMERAPOSITION;
float4 gFogColor < string renderState="FOGCOLOR"; >;
static const float PI = 3.14159265f;
float gTime : TIME;
int gCapsMaxAnisotropy < string deviceCaps="MaxAnisotropy"; >;
int CUSTOMFLAGS < string skipUnusedParameters = "yes"; >;

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
    float3 Normal : TEXCOORD1;
    float3 WorldPos : TEXCOORD2;
    float DistFade : TEXCOORD3;
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
// Vertex Shader 
//--------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    // set proper position and scale of the quad
    VS.Position.xyz = float3(- 0.5 + VS.TexCoord.xy, 0);
	
    // shape the donut
    float rad = sElementShape.x / PI;
    float a = -PI + VS.Position.x * 2 * PI;
    float3 vertPos = float3(sin(a) * rad, 1, -cos(a) * rad + cos(PI * 0.5) * rad);
    float3 Normal = float3(sin(a), 1, -cos(a));
    float r2 = sElementShape.y / PI;
    float a2 = -PI + VS.Position.y * 2 * PI;
    vertPos.xz *= (rad + r2 - r2 * cos(a2)) / rad;
    vertPos.y = -r2 * sin(a2);
    Normal = float3(cos(a2) * sin(a), sin(a2), cos(a2) * -cos(a));
	
    VS.Position.xyz = -vertPos;
    if (sIsBillboard) {VS.Position.xyz = VS.Position.xzy; Normal.xyz = Normal.xzy;}	
	
    VS.Position.xyz *= sElementSize;
	
    // create WorldMatrix for the quad
    float4x4 sWorld = createWorldMatrix(sElementPosition, sElementRotation);

    if (!sFlipTexture) VS.TexCoord.y = 1 - VS.TexCoord.y;
    if ((sFlipVertex) && (!sIsBillboard)) VS.Position.xyz = VS.Position.xzy;

    // calculate screen position of the vertex
    if (sIsBillboard) 
    {
        float4x4 sWorldView = mul(sWorld, gView);
        float3 sBillView = VS.Position.xyz + sWorldView[3].xyz;
        PS.WorldPos = VS.Position.xyz + sWorld[3].xyz;
        PS.Normal = mul(Normal, (float3x3)gViewInverse).xyz;
        PS.Position = mul(float4(sBillView, 1), gProjection);
    }
    else
    {
        float4 wPos = mul(float4( VS.Position, 1), sWorld);
        PS.WorldPos = wPos.xyz;
        PS.Normal = mul(Normal, (float3x3)sWorld).xyz;
        float4 vPos = mul(wPos, gView);
        PS.Position = mul(vPos, gProjection);
    }
	
    // get clip values
    float nearClip = - gProjection[3][2] / gProjection[2][2];
    float farClip = (gProjection[3][2] / (1 - gProjection[2][2]));
	
    // fade
    float DistFromCam = distance(gCameraPosition, sElementPosition.xyz);
    float elementSize = max(max(sElementSize.x, sElementSize.y), sElementSize.z);
    float2 DistFade = float2(min(gDistFade.x, farClip - elementSize / 2), min(gDistFade.y, farClip - elementSize /2 - (gDistFade.x - gDistFade.y)));
    PS.DistFade = saturate((DistFromCam - DistFade.x)/(DistFade.y - DistFade.x));

    // pass texCoords and vertex color to PS
    PS.TexCoord = (VS.TexCoord * uvMul) + uvPos;
    PS.Diffuse = VS.Diffuse * sElementColor;
    return PS;
}

//--------------------------------------------------------------------------------------
// Pixel shaders 
//--------------------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{	
    // pass vertex color
    float4 finalColor = PS.Diffuse;
	
    // add a light specular (to both sides)
    float NdotL = dot(normalize(PS.Normal), normalize(gCameraPosition - PS.WorldPos));
    NdotL = pow(NdotL, 2);
    float fAttenuation = saturate(NdotL);
	
    // apply attenuation
    finalColor.rgb *= 0.5 + 0.5 * saturate(fAttenuation);
	
    // apply distFade
    finalColor.a *= saturate( PS.DistFade );

    return saturate(finalColor);
}

//--------------------------------------------------------------------------------------
// Techniques
//--------------------------------------------------------------------------------------
technique dxDrawPrimitive3Dfx_ring_ap
{
  pass P0
  {
    ZEnable = true;
    ZFunc = LessEqual;
    ZWriteEnable = true;
    CullMode = 3;
    ShadeMode = Gouraud;
    AlphaBlendEnable = true;
    SrcBlend = SrcAlpha;
    DestBlend = fDestBlend;
    AlphaTestEnable = true;
    AlphaRef = 1;
    AlphaFunc = GreaterEqual;
    Lighting = false;
    FogEnable = false;
    VertexShader = compile vs_2_0 VertexShaderFunction();
    PixelShader  = compile ps_2_0 PixelShaderFunction();
  }
  pass P1
  {
    ZEnable = true;
    ZFunc = LessEqual;
    ZWriteEnable = true;
    CullMode = 2;
    ShadeMode = Gouraud;
    AlphaBlendEnable = true;
    SrcBlend = SrcAlpha;
    DestBlend = fDestBlend;
    AlphaTestEnable = true;
    AlphaRef = 1;
    AlphaFunc = GreaterEqual;
    Lighting = false;
    FogEnable = false;
    VertexShader = compile vs_2_0 VertexShaderFunction();
    PixelShader  = compile ps_2_0 PixelShaderFunction();
  }
}

// Fallback
technique fallback
{
  pass P0
  {
    // Just draw normally
  }
}
