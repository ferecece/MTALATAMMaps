//---------------------------------------------------------------------
//-- Settings
//---------------------------------------------------------------------
bool gIsInWater = false;

float gColorPow = 1;
float4 gColorMul = float4(1,1,1,1);
float gColorAlpha = 1;

float fFogEnable = false;
float fFogMul = 1;
float fFogPow = 1;

float3 gRescale = float3(1,1,1);
float3 gRotate = float3(0,0,0);
float3 gAnimate = float3(0,0,0);

float3 gStretch = (1,1,1);
float3 gMove = (0,0,0);

texture sTextureCube;

//---------------------------------------------------------------------
//-- Include some common things
//---------------------------------------------------------------------
static const float PI = 3.14159265f;
float4x4 gWorld : WORLD;
float4x4 gView : VIEW;
float4x4 gViewInverse : VIEWINVERSE;
float4x4 gProjection : PROJECTION;
float4x4 gWorldViewProjection : WORLDVIEWPROJECTION;
float3 gCameraPosition : CAMERAPOSITION;
float3 gCameraDirection : CAMERADIRECTION;
matrix gProjectionMainScene : PROJECTION_MAIN_SCENE;
int gFogEnable < string renderState="FOGENABLE"; >;
float4 gFogColor < string renderState="FOGCOLOR"; >;
float gFogStart < string renderState="FOGSTART"; >;
float gFogEnd < string renderState="FOGEND"; >;
float gTime : TIME;

//---------------------------------------------------------------------
//-- Sampler for the main texture (needed for pixel shaders)
//---------------------------------------------------------------------
samplerCUBE envMapSampler = sampler_state
{
    Texture = (sTextureCube);
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    MIPMAPLODBIAS = 0.000000;
};

//---------------------------------------------------------------------
//-- Structure of data sent to the vertex shader
//--------------------------------------------------------------------- 
struct VSInput
{
    float4 Position : POSITION;
    float3 TexCoord : TEXCOORD0;
};

//---------------------------------------------------------------------
//-- Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION; 
    float3 TexCoord : TEXCOORD0;
    float4 PositionVS : TEXCOORD1;
    float3 TexCoord1 : TEXCOORD2;
    float3 WorldPos : TEXCOORD3;
};

//-----------------------------------------------------------------------------
//-- eulerRotate
//-----------------------------------------------------------------------------
float3x3 eulerRotate(float3 Rotate)
{
    float cosX,sinX;
    float cosY,sinY;
    float cosZ,sinZ;
	
    sincos(Rotate.x ,sinX,cosX);
    sincos(-Rotate.y ,sinY,cosY);
    sincos(Rotate.z ,sinZ,cosZ);

    return float3x3(
		cosY * cosZ + sinX * sinY * sinZ, -cosX * sinZ,  sinX * cosY * sinZ - sinY * cosZ,
		cosY * sinZ - sinX * sinY * cosZ,  cosX * cosZ, -sinY * sinZ - sinX * cosY * cosZ,
		cosX * sinY,                       sinX,         cosX * cosY
	);
}

//-----------------------------------------------------------------------------
//-- vertex shader
//-----------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;
    PS.PositionVS = VS.Position;
    float farClip = gProjectionMainScene[3][2] / (1 - gProjectionMainScene[2][2]);
    if ((gFogEnable) && (gIsInWater)) farClip = min(gFogStart, farClip);
    VS.Position.xyz *= 0.32 * max(230, farClip) * gRescale;
    float4x4 sWorld = gWorld; sWorld[3].xyz = float3(0,0,0);
    float4 worldPos = mul(VS.Position, sWorld);
PS.WorldPos = mul(float4(VS.Position.xyz, 1), gWorld);
    float4x4 sView = gView; sView[3].xyz = float3(0,0,0);
    float4 viewPos = mul(worldPos, sView);
    PS.Position = mul(viewPos, gProjection);
    float3 sAnim = float3( fmod( gTime * gAnimate.x, 2 * PI ), fmod( gTime * gAnimate.y, 2 * PI ), fmod( gTime * gAnimate.z, 2 * PI )); 
    float3 viewVec = normalize( worldPos.xyz - 0 );
    float3x3 rotMatrix = eulerRotate( gRotate + sAnim );
    PS.TexCoord = mul( rotMatrix, viewVec );
    PS.TexCoord = PS.TexCoord.xzy;	
	
	
PS.TexCoord1 = VS.TexCoord;
    return PS;
}

//------------------------------------------------------------------------------------------
// AddObjectSpaceDepth
//------------------------------------------------------------------------------------------
float3 AddObjectSpaceDepth( float3 texel, float posZ )
{
    if ( !gFogEnable )
        return texel;

    float fogAmount = 1 - saturate( pow( abs( posZ ), fFogPow ) * fFogMul);
    if (posZ < 0) fogAmount = 1;
    texel.rgb = lerp( texel.rgb, gFogColor, saturate( fogAmount ));
    return texel;
}


float mod(float x, float y)
{
    return x - y * floor(x/y);
}

float3 mod3(float3 x, float3 y)
{
    return x - y * floor(x/y);
}
//12
#define iterations 4.4
#define formuparam2 0.79
 
// 9
#define volsteps 7
#define stepsize 0.290
 
#define zoom 1.0
#define tile   0.850
#define speed2  0.2
 
#define brightness 0.0015
#define darkmatter 0.50
#define distfading 0.560
#define saturation 1.1


#define transverseSpeed zoom*2.0
#define cloud 0.05


float field(float3 p) {
	
    float sTime = gTime * 0.01;
    float strength = 7. + .03 * log(1.e-6 + frac(sin(sTime) * 4373.11));
    float accum = 0.;
    float prev = 0.;
    float tw = 0.;


    for (int i = 0; i < 6; ++i) {
        float mag = dot(p, p);
        p = abs(p) / mag + float3(-.5, -.8 + 0.1*sin(sTime*0.7 + 2.0), -1.1+0.3*cos(sTime*0.3));
        float w = exp(-float(i) / 7.);
        accum += w * exp(-strength * pow(abs(mag - prev), 2.3));
        tw += w;
        prev = mag;
    }
    return max(0., 5. * accum / tw - .7);
}



//-----------------------------------------------------------------------------
//-- pixel shader
//-----------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    // Get TexCoord
    float2 position = PS.TexCoord;


    float speed = 0;
    float formuparam = formuparam2;

       
    float3 sd = normalize(gViewInverse[2].xyz); // normalize(float3(0.507, 0.2, -0.507));	//  
    float3 ray = normalize(PS.WorldPos - gCameraPosition).xyz;
	
	
    //mouse rotation
    float a_xz = sd.x;
    float a_yz = sd.y;
    float a_xy = sd.z;	
	
    float2x2 rot_xz = float2x2(cos(a_xz),sin(a_xz),-sin(a_xz),cos(a_xz));
    float2x2 rot_yz = float2x2(cos(a_yz),sin(a_yz),-sin(a_yz),cos(a_yz));
    float2x2 rot_xy = float2x2(cos(a_xy),sin(a_xy),-sin(a_xy),cos(a_xy));

    float v2 =1.0;

    float3 dir=ray.xyz; // float3(uv*zoom,1.);
 
    float3 from = 0;   //float3(0.0, 0.0,0.0);
               
    float3 forward = float3(0,0,0.00);

    dir.xy = mul(dir.xy,rot_xy);
    forward.xy = mul(forward.xy,rot_xy);

    dir.xz = mul(dir.xz,rot_xz);
    forward.xz = mul(forward.xz,rot_xz);

    dir.yz = mul(dir.yz,rot_yz);
    forward.yz = mul(forward.yz,rot_yz);

    from.xy = mul(from.xy,-rot_xy);
    from.xz =mul(from.xz,rot_xz);
    from.yz = mul(from.yz,rot_yz);

dir=ray.xyz;
from = gCameraPosition * 0.0005;
    //zoom
    float zooom = speed; //(time2-3311.)*speed;
    from += forward* 0.00;//zooom;
    float sampleShift = mod( zooom, stepsize );
	 
    float zoffset = -sampleShift;
    sampleShift /= stepsize; // make from 0 to 1

    //volumetric rendering
    float s=0.24;
    float s3 = s + stepsize/2.0;
    float3 v=float3(0,0,0);
    float t3 = 0.0;
	
    float3 outCol = float3(0,0,0);
    for (int r=0; r<volsteps; r++) {
        float3 p2=from+(s+zoffset)*dir;// + float3(0.,0.,zoffset);
        float3 p3=from+(s3+zoffset)*dir;// + float3(0.,0.,zoffset);
		
        p2 = abs(float3(tile,tile,tile)-mod3(p2,float3(tile*2,tile*2,tile*2))); // tiling fold
        p3 = abs(float3(tile,tile,tile)-mod3(p3,float3(tile*2,tile*2,tile*2))); // tiling fold
		
        #ifdef cloud
        t3 = field(p3);
        #endif
		
        float pa,a=pa=0.;
        for (int i=0; i<iterations; i++) {
            p2=abs(p2)/dot(p2,p2)-formuparam; // the magic formula
            //p=abs(p)/max(dot(p,p),0.005)-formuparam; // another interesting way to reduce noise
            float D = abs(length(p2)-pa); // absolute sum of average change
            a += i > 7 ? min( 12., D) : D;
            pa=length(p2);
        }
		
        //float dm=max(0.,darkmatter-a*a*.001); //dark matter
        a*=a*a; // add contrast
        //if (r>3) fade*=1.-dm; // dark matter, don't render near
        // brightens stuff up a bit
        float s1 = s+zoffset;
        // need closed form expression for this, now that we shift samples
        float fade = pow(distfading,max(0.,float(r)-sampleShift));
		
		
        t3 += fade;
		
        v+=fade;
        //outCol -= fade;

        // fade out samples as they approach the camera
        if( r == 0 )
            fade *= (1. - (sampleShift));
            // fade in samples as they approach from the distance
        if( r == volsteps-1 )
            fade *= sampleShift;
        v+=float3(s1,s1*s1,s1*s1*s1*s1)*a*brightness*fade; // coloring based on distance

        outCol += lerp(.4, 1., v2) * float3(1.8 * t3 * t3 * t3, 1.4 * t3 * t3, t3) * fade;
	
        s+=stepsize;
        s3 += stepsize;
        
    }
    
    float lenV = length(v);		
    v = lerp(float3(lenV,lenV,lenV),v,saturation); //color adjust

    float4 forCol2 = float4(v*.01,1.);
	
    #ifdef cloud
        outCol *= cloud;
    #endif
	
   //outCol.b = 0;
    outCol.r = 0.5*lerp(0, outCol.g, outCol.b);
    outCol.b = 0.01;
    outCol.g = 0.01;

//	outCol.bg = lerp(outCol.gb, outCol.bg, 0.5*(cos(time*0.01) + 1.0));

    return float4(forCol2 + float4(outCol, 1.0));
	
}

//-----------------------------------------------------------------------------
//-- Techniques
//-----------------------------------------------------------------------------
technique Skybox
{
    pass P0
    {
        FogEnable = false;
        AlphaRef = 1;
        AlphaBlendEnable = true;
        ZWriteEnable = false;
        VertexShader = compile vs_3_0 VertexShaderFunction();
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
}