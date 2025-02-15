--
-- c_skidmarks.lua
--

g_Settings = {}

local myShader
local Settings = {}
Settings.var = {}


-----------------------------------------------------------------------------
-- Presets
-----------------------------------------------------------------------------
function setTypeTooBright()
    local v = Settings.var
    v.hue1=0.00
    v.hue2=0.02
    v.hue3=0.06
    v.hue4=0.11
    v.alpha1=1.00
    v.alpha2=0.84
    v.alpha3=0.71
    v.alpha4=0.55
    v.saturation=1.00
    v.lightness=0.66
    v.pos_changes_hue=0.39
    v.time_changes_hue=0.13
    v.filth=0.06
end

-----------------------------------------------------------------------------
-- Apply settings
-----------------------------------------------------------------------------
function applySettings()
	if not myShader then return end
	local v = Settings.var
	dxSetShaderValue( myShader, "sHSVa1", v.hue1, v.saturation, v.lightness, v.alpha1 )
	dxSetShaderValue( myShader, "sHSVa2", v.hue2, v.saturation, v.lightness, v.alpha2 )
	dxSetShaderValue( myShader, "sHSVa3", v.hue3, v.saturation, v.lightness, v.alpha3 )
	dxSetShaderValue( myShader, "sHSVa4", v.hue4, v.saturation, v.lightness, v.alpha4 )
	dxSetShaderValue( myShader, "sPosAmount", v.pos_changes_hue )
	dxSetShaderValue( myShader, "sSpeed", v.time_changes_hue )
	dxSetShaderValue( myShader, "sFilth", v.filth )
end

-----------------------------------------------------------------------------
-- Client start shader
-----------------------------------------------------------------------------
-- Create shader
myShader, tec = dxCreateShader ( "skidmarks.fx" )
engineApplyShaderToWorldTexture ( myShader, "particleskid" )
setTypeTooBright()
applySettings()
