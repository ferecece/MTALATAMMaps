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
function setTypeBlack()
    local v = Settings.var
    v.hue1=0.00
    v.hue2=0.00
    v.hue3=0.00
    v.hue4=0.00
    v.alpha1=1.00
    v.alpha2=0.84
    v.alpha3=0.71
    v.alpha4=0.55
    v.saturation=1.00
    v.lightness=0.00
    v.pos_changes_hue=0.00
    v.time_changes_hue=0.00
    v.filth=1.00
end

function setTypeSubtle()
	local v = Settings.var
    v.hue1=0.00
    v.hue2=0.00
    v.hue3=0.00
    v.hue4=0.00
    v.alpha1=1.00
    v.alpha2=0.83
    v.alpha3=0.63
    v.alpha4=0.40
    v.saturation=1.00
    v.lightness=0.070
    v.pos_changes_hue=0.21
    v.time_changes_hue=0.02
    v.filth=1.00
end

function setTypeBright()
    local v = Settings.var
    v.hue1=0.00
    v.hue2=0.00
    v.hue3=0.00
    v.hue4=0.00
    v.alpha1=1.00
    v.alpha2=0.84
    v.alpha3=0.71
    v.alpha4=0.55
    v.saturation=1.00
    v.lightness=0.66
    v.pos_changes_hue=0.06
    v.time_changes_hue=0.06
    v.filth=1.00
end

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


myShader, tec = dxCreateShader ( "skidmarks.fx" )
engineApplyShaderToWorldTexture ( myShader, "particleskid" )
setTypeTooBright()
applySettings()