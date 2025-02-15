//
// file: billboard.fx
//

//------------------------------------------------------------------------------------------
// Variables
//------------------------------------------------------------------------------------------
float gColorMult = 1;
bool bZWrite = true;
int fCullMode = 2;
float fAlphaRef = 1;

float fMovSpeed = 0.05;
float2 fDivImg = float2(4, 4);
bool bImgInv = false;

float fTransFac = 2;
int iEffectID = 3;
int fNumberBinds = 5;

texture sTex0;			

//------------------------------------------------------------------------------------------
// Include some common stuff
//------------------------------------------------------------------------------------------
float4x4 gWorld : WORLD;
float4x4 gView : VIEW;
float4x4 gWorldView : WORLDVIEW;
float4x4 gProjection : PROJECTION;
float4x4 gViewProjection : VIEWPROJECTION;
float4x4 gWorldViewProjection : WORLDVIEWPROJECTION;
float4x4 gViewInverse : VIEWINVERSE;
float3 gCameraDirection : CAMERADIRECTION;
texture secondRT < string renderTarget = "yes"; >;
texture gTexture0 < string textureState="0,Texture"; >;
matrix gProjectionMainScene : PROJECTION_MAIN_SCENE;
float3 gCameraPosition : CAMERAPOSITION;
float3 gCameraRotation : CAMERAROTATION;

int CUSTOMFLAGS <string skipUnusedParameters = "yes"; >;

int gFogEnable < string renderState="FOGENABLE"; >;
float4 gFogColor < string renderState="FOGCOLOR"; >;
float gFogStart < string renderState="FOGSTART"; >;
float gFogEnd < string renderState="FOGEND"; >;

int gLighting < string renderState="LIGHTING"; >;
int gDiffuseMaterialSource  < string renderState="DIFFUSEMATERIALSOURCE"; >;
int gAmbientMaterialSource  < string renderState="AMBIENTMATERIALSOURCE"; >;
int gEmissiveMaterialSource  < string renderState="EMISSIVEMATERIALSOURCE"; >;
float4 gGlobalAmbient < string renderState="AMBIENT"; >;
float4 gMaterialAmbient < string materialState="Ambient"; >;
float4 gMaterialDiffuse < string materialState="Diffuse"; >;
float4 gMaterialEmissive < string materialState="Emissive"; >;

float gTime : TIME;

//------------------------------------------------------------------------------------------
// Samplers for the textures
//------------------------------------------------------------------------------------------
sampler Sampler0 = sampler_state
{
    Texture     = (sTex0);
};

//------------------------------------------------------------------------------------------
// Structure of data sent to the vertex shader
//------------------------------------------------------------------------------------------
struct VSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
};

//------------------------------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//------------------------------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord0 : TEXCOORD0;
    float2 TexCoord1 : TEXCOORD1;
    float2 TexCoord2 : TEXCOORD2;
    float Progress : TEXCOORD3;
};

//------------------------------------------------------------------------------------------
// MTACalcGTABuildingDiffuse
// - Calculate GTA lighting for buildings
//------------------------------------------------------------------------------------------
float4 MTACalcGTABuildingDiffuse( float4 InDiffuse )
{
    float4 OutDiffuse;

    if ( !gLighting )
    {
        // If lighting render state is off, pass through the vertex color
        OutDiffuse = InDiffuse;
    }
    else
    {
        // If lighting render state is on, calculate diffuse color by doing what D3D usually does
        float4 ambient  = gAmbientMaterialSource  == 0 ? gMaterialAmbient  : InDiffuse;
        float4 diffuse  = gDiffuseMaterialSource  == 0 ? gMaterialDiffuse  : InDiffuse;
        float4 emissive = gEmissiveMaterialSource == 0 ? gMaterialEmissive : InDiffuse;
        OutDiffuse = gGlobalAmbient * saturate( ambient + emissive );
        OutDiffuse.a *= diffuse.a;
    }
    return OutDiffuse;
}

//------------------------------------------------------------------------------------------
// VertexShaderFunction
//  1. Read from VS structure
//  2. Process
//  3. Write to PS structure
//------------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    PS.Position = mul(VS.Position,gWorldViewProjection);

    PS.Diffuse = MTACalcGTABuildingDiffuse(VS.Diffuse);
    PS.Diffuse.rgb *= gColorMult;

    PS.TexCoord0 = VS.TexCoord;

    // Calculate TexCoords
	float timer1 = gTime * fMovSpeed;
    float2 posUV1 = float2(fmod( timer1, 1 ), fmod( timer1 / fDivImg.y, 1 ));
    int2 integrate1 = fDivImg * posUV1;
	
	float timer2 = gTime * fMovSpeed + (1 / fDivImg);
    float2 posUV2 = float2(fmod( timer2, 1 ), fmod( timer2 / fDivImg.y, 1 )); 
    int2 integrate2 = fDivImg * posUV2;
	
    float2 coord1 = VS.TexCoord;
    coord1 /= fDivImg;
    coord1 += integrate1 / fDivImg;
	
    float2 coord2 = VS.TexCoord;
    coord2 /= fDivImg;
    coord2 += integrate2 / fDivImg;
	
    if (bImgInv) coord1 = 1 - coord1;	
	PS.TexCoord1 = coord1;
	
    if (bImgInv) coord2 = 1 - coord2;
	PS.TexCoord2 = coord2;
	
    PS.Progress = saturate(abs(fTransFac) * fmod((gTime) * fMovSpeed * fDivImg.x, 1));

    return PS;
}

//------------------------------------------------------------------------------------------
// PixelShaderFunction
//  1. Read from PS structure
//  2. Process
//  3. Return pixel color
//------------------------------------------------------------------------------------------
float4 doBlinds(float2 textureCoord0, float2 textureCoord1, float2 textureCoord2, float numberOfBlinds, float progress) 
{
	if (frac( textureCoord0.y * numberOfBlinds) < (1 - progress)) {
		return tex2D(Sampler0, textureCoord1);
	} else {
		return tex2D(Sampler0, textureCoord2);
	}
}

float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float4 Color = 1;
	
	if (iEffectID == 1)
    {
        Color = tex2D(Sampler0, PS.TexCoord1);
    } else if (iEffectID == 2)
    {
        float4 Color1 = tex2D(Sampler0, PS.TexCoord1);
        float4 Color2 = tex2D(Sampler0, PS.TexCoord2);
        Color = lerp(Color1, Color2, PS.Progress);    
    } else if (iEffectID == 3)
    {
        if (fTransFac < 0) PS.TexCoord0.y = 1 - PS.TexCoord0.y;
        Color = doBlinds(PS.TexCoord0, PS.TexCoord1, PS.TexCoord2, fNumberBinds, PS.Progress);
    }

    Color = Color * PS.Diffuse;
    return Color;  
}

//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique world
{
    pass P0
    {
        AlphaRef = fAlphaRef;
		ZWriteEnable = bZWrite;
        AlphaBlendEnable = true;
        CullMode = fCullMode;
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
