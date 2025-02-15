//
// disable.fx
//

float4 ClearMe() : COLOR0
{	
    return 0;	
}

technique Nothing
{
    pass p0
    {
        Lighting = false;
        FogEnable = false;
        ColorVertex = false;
        ZFunc = Never;
        ColorOp[0] = Disable;
        AlphaOp[0] = Disable;
        ColorOp[1] = Disable;
        AlphaOp[1] = Disable;
        AlphaBlendEnable = TRUE;
        PixelShader = compile ps_2_0 ClearMe();
    }
}
