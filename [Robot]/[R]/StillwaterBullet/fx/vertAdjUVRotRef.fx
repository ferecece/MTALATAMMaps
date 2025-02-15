//
// file: vertAdjUVRot.fx
//

//---------------------------------------------------------------------
// Variables
//---------------------------------------------------------------------
float gColorMult = 1;
float2 gUVSpeed = float2(0,0);
bool bZWrite = true;
int fCullMode = 2;
float fAlphaRef = 0.7;
float3 fPosOffset = float3(0,0,0);
float3 gRotate = float3(0,0,0);
float3 gRotateRef = float3(0,0,0);
bool gAnimate = false;	

texture sRefBoxTexture;

//---------------------------------------------------------------------
//-- Sampler for the main texture (needed for pixel shaders)
//---------------------------------------------------------------------

samplerCUBE envMapSampler1 = sampler_state
{
    Texture = (sRefBoxTexture);
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU  = Wrap;
    AddressV  = Wrap;
    MIPMAPLODBIAS = 0.000000;
};

//---------------------------------------------------------------------
// Include some common stuff
//---------------------------------------------------------------------
float4x4 gWorld : WORLD;
float4x4 gWorldInverseTranspose : WORLDINVERSETRANSPOSE;
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

int CUSTOMFLAGS < string createNormals = "yes";  string skipUnusedParameters = "yes";>;

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
    Texture     = (gTexture0);
};

//---------------------------------------------------------------------
// Structure of data sent to the vertex shader
//---------------------------------------------------------------------
struct VSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float3 Normal : NORMAL0;
    float2 TexCoord : TEXCOORD0;
};

//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
    float3 EyeVector : TEXCOORD1;
    float3 Normal : TEXCOORD2;
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
//------------------------------------------------------------------------------------------
// MTAFixUpNormal
// - Make sure the normal is valid
//------------------------------------------------------------------------------------------
void MTAFixUpNormal( in out float3 OutNormal )
{
    // Incase we have no normal inputted
    if ( OutNormal.x == 0 && OutNormal.y == 0 && OutNormal.z == 0 )
        OutNormal = float3(0,0,1);   // Default to up
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
	
    // Make sure normal is valid
    MTAFixUpNormal( VS.Normal );
	
    VS.Position.xyz -= fPosOffset;
	VS.Position.xyz = mul(eulRotate( gRotate, gAnimate), VS.Position.xyz);
    VS.Position.xyz += fPosOffset;

	VS.Normal.xyz = mul(eulRotate( gRotate, gAnimate), VS.Normal.xyz);
	
    float4 worldPos = mul(VS.Position, gWorld);
    PS.Normal = mul(VS.Normal, (float3x3)gWorldInverseTranspose);
	
    PS.Position = mul(VS.Position,gWorldViewProjection);

    PS.Diffuse = MTACalcGTABuildingDiffuse(VS.Diffuse);
    PS.Diffuse.rgb *= gColorMult;
	
    float2 anim = float2(fmod(gTime * gUVSpeed.x, 1), fmod(gTime * gUVSpeed.y, 1));
    PS.TexCoord.xy += float2(anim.x, anim.y);
    PS.TexCoord = VS.TexCoord;
	
    PS.EyeVector.xzy = (worldPos.xyz - gCameraPosition);
    return PS;
}

//-----------------------------------------------------------------------------
//-- PixelShader
//-----------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float3 eyeVec = normalize(PS.EyeVector.xyz);
    float3 normal = normalize(PS.Normal);
    float3 refVec = reflect(eyeVec, normal);
    float4 RefTex = texCUBE(envMapSampler1, refVec);
    RefTex.rgb = pow(RefTex.rgb,1.1);
    RefTex.rgb -= 0.1;
    float4 texel = tex2D(Sampler0, PS.TexCoord.xy);
    float4 outPut = float4(lerp(RefTex.rgb, texel.rgb, texel.a), PS.Diffuse.a);
	
    return saturate(outPut);
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
        PixelShader = compile ps_2_0 PixelShaderFunction();
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
