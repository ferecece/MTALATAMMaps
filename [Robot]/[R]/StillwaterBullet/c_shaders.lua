--
-- c_shaders.lua
--

local shaderTable = {}
local shaderList = 
	{
		{ 
			shader = {"fx/disable.fx", 3, false},
			texNames = {"cloud*"},
			texList = {},
			settings = {}
		},		
		{ 
			shader = {"fx/depthBias.fx", 3, false},
			texNames = {"unnamed"},
			texList = {},
			settings = {}
		},
		{
			shader = {"fx/vertAdj.fx", 1, false},
			texNames = {"11_*", "321backplate", "3_Yellow_Lights_GLOW", "a1", "a2", "a4", 
				"BaseTrackConcrete", "BigYellow", "BlueHolo_Add_GLOW", "BrayPowerRoof", "cityfloor_sb_nomip_GLOW", 
				"col_arrows1_GLOW_ADD", "env264", "fence", "rh_floor_panel001","11_smallwindow_nomip",
				"Fesisar_2", "Flatgrey", "flicker1nonalpha_GLOW", "flicker2nonalpha_GLOW", "girder_1", "grill001_sb", "Grille", "Harimau3DLogo_Add_Glow", 
				"HighGrid_shinemap", "jumplight_GLOW", "Lightglow01_GLOW_BLEND", "light_shaft_ADD_nomip", "rh_bluewindows_small_shinemap",
				"Newfloorpanel", "NewGoathecki4", "NewPitmen", "Newstartgrid", "panel002_sb", "plate_nomip", "radioeffect002_ADD", 
				"RedHolo_ADD_GLOW", "Rend*", "rh_*", "startline_*", "track_bracket_01", "track_transparent2", "Trend*", "vehicles_sb", 
				"wall_1", "weapon_under", "whitenonalpha", "_magsurface*", "_magwall_*", "_pitwall6_1", "_wall3_door1", "_walltop6_1"},
			texList = {},
			settings = {{"gColorMult", 0.6},{"bZWrite", true},{"fCullMode", 2},{"fAlphaRef", 1}}
		},	
		{
			shader = {"fx/vertAdjBasic.fx", 1, false}, 
			texNames = {"11_tree_01","crowd", "ash_cemntgrey", "11_walls1", "11_walls2", "startline_window1_shinemap", "11_fence", "wogreydefault_1"},
			texList = {},
			settings = {{"gColorMult", 0.6}}
		},
		{
			shader = {"fx/vertAdj.fx", 1, false},
			texNames = {"startlinemetal00*"},
			texList = {},
			settings = {{"gColorMult", 0.6},{"bZWrite", true},{"fCullMode", 2},{"fAlphaRef", 0.4}}
		},
		{
			shader = {"fx/vertAdj.fx", 1, false},
			texNames = {"plate2", "plate3", "fence", "feisar_1to2_ratio"},
			texList = {},
			settings = {{"gColorMult", 0.6},{"bZWrite", true},{"fCullMode", 1},{"fAlphaRef", 1}}
		},
		{
			shader = {"fx/vertAdj.fx", 1, false},
			texNames = {"11_grill_glow", "11_window4_glow"},
			texList = {},
			settings = {{"gColorMult", 1},{"bZWrite",true},{"fCullMode", 1},{"fAlphaRef", 1}}
		},
		{
			shader = {"fx/vertAdj.fx", 1, false},
			texNames = {"11_panel_shinemap"},
			texList = {},
			settings = {{"gColorMult", 0.85},{"bZWrite", true},{"fCullMode", 2}}
		},
		{
			shader = {"fx/vertAdj.fx", 1, false},
			texNames = {"11_flatpanel2", "3_yellow_lights_glow", "Lightpanel01_GLOW",
				"blueholo_add_glow", "harimau3dlogo_add_glow", "11_light_glow"},
			texList = {},
			settings = {{"gColorMult", 1},{"bZWrite", true},{"fCullMode", 2}}
		},		
		{
			shader = {"fx/vertAdjBlend.fx", 1, false},
			texNames = {"11_Spotlight_GLOW_BLEND", "11_env2", "11_camflash_Glow_Add", "11_lightshaft_ADD", "col_arrows1_GLOW_ADD", "envmap_stripe1",
				"light_shaft_ADD_nomip", "Lightglow01_GLOW_BLEND", "radioeffect002_ADD"},
			texList = {},
			settings = {{"gColorMult", 0.6},{"bZWrite", false},{"fCullMode", 1}}
		},
		{
			shader = {"fx/vertAdjBlend.fx", 1, false},
			texNames = {"11_neonx_glow_add"},
			texList = {},
			settings = {{"gColorMult", 1},{"bZWrite", true},{"fCullMode", 1}}
		},
		
		{
			shader = {"fx/vertAdjBlendUV.fx", 1, false},
			texNames = {"startline_lasersmokex_add*"},
			texList = {},
			settings = {{"gColorMult", 0.4}, {"gUVSpeed", {1,0}}, {"bZWrite", false}, {"fCullMode", 2}}
		},	
		{
			shader = {"fx/vertAdjBlendUV.fx", 1, false},
			texNames = {"startline_laserx_ADD_GLOW"},
			texList = {},
			settings = {{"gColorMult", 1}, {"gUVSpeed", {1,0}}, {"bZWrite", false}, {"fCullMode", 1}}
		},
		{
			shader = {"fx/vertAdjBlendUV.fx", 1, false},
			texNames = {"startline_laserpulse_add_glow", "envmap_stripe1"},
			texList = {},
			settings = {{"gColorMult", 0.8}, {"gUVSpeed", {1,0}}, {"bZWrite", false}, {"fCullMode", 1}}
		},
		{ 
			shader = {"fx/vertAdjBlendUV.fx", 1, false},
			texNames = {"envtest4bitSingle"},
			texList = {},
			settings = {{"gColorMult", 1}, {"gUVSpeed", {0,-1}},{"bZWrite", true}, {"fCullMode", 2}}
		},
		{ 
			shader = {"fx/vertAdjBlendUV.fx", 1, false},
			texNames = {"col_display7x_glow"},
			texList = {},
			settings = {{"gColorMult", 3}, {"gUVSpeed", {-1,0}}, {"bZWrite", true}, {"fCullMode", 1}}
		},	
		{ 
			shader = {"fx/vertAdjBlendUV.fx", 1, false},
			texNames = {"11_plasmax_ADD"},
			texList = {},
			settings = {{"gColorMult", 1}, {"gUVSpeed", {0,-1}}, {"bZWrite", true}, {"fCullMode", 1}}
		},
		{ 
			shader = {"fx/vertAdjUV.fx", 1, false},
			texNames = {"newag4"},
			texList = {},
			settings = {{"gColorMult", 0.6}, {"gUVSpeed", {1,0}}, {"bZWrite", true}, {"fCullMode", 2}}
		},
		{ 
			shader = {"fx/vertAdjUV.fx", 1, false},
			texNames = {"11_stripes_glow"},
			texList = {},
			settings = {{"gColorMult", 1}, {"gUVSpeed", {0,-1}}, {"bZWrite", true}, {"fCullMode", 2}}
		},		
		{ 
			shader = {"fx/vertAdjUVRotRef.fx", 1, false},
			texNames = {"11_neon_glowx_add"},
			texList = {{"tex/refbox.dds", "sRefBoxTexture", "dxt1"}},
			settings = {{"gRotateRef", {0, 0, math.rad(90)}},{"gColorMult", 0.6}, {"fPosOffset", {0,0,0}},
				{"gRotate", {0,0,1}}, {"gAnimate", true}, {"gUVSpeed", {1,0}},{"bZWrite", true},{"fCullMode", 1}}
		},		
		{ 
			shader = {"fx/vertAdjUVMul.fx", 1, false}, 
			texNames = {"harimau_glow"},
			texList = {{"tex/Random_1-6.png", "sTex0", "dxt3"}},
			settings = {{"gColorMult", 1}, {"gUVSpeed", {1,0}}, {"gUVMul", {1/3,1/2}}, {"bZWrite", true}, {"fCullMode", 2}}
		},		
		{
			shader = {"fx/billboard.fx", 2, false},
			texNames = {"billboard2"},
			texList = {{"tex/Harimau_1-9.png", "sTex0", "dxt3"}},
			settings = {{"fDivImg", {3,3}}, {"fMovSpeed", 0.1}, {"bImgInv", false}, {"fTransFac", 2}, {"iEffectID", 3}, 
				{"fNumberBinds", 5}, {"gColorMult", 0.9}, {"bZWrite", true}, {"fCullMode", 1}}
		},
		{
			shader = {"fx/billboard.fx", 2, false},
			texNames = {"billboard4"},
			texList = {{"tex/Auricom_1-9.png", "sTex0", "dxt3"}},
			settings = {{"fDivImg", {3,3}}, {"fMovSpeed", 0.1}, {"bImgInv", false}, {"fTransFac", 2}, {"iEffectID", 3}, 
				{"fNumberBinds", 5}, {"gColorMult", 0.9}, {"bZWrite", true}, {"fCullMode", 1}}
		},
		{
			shader = {"fx/billboard.fx", 2, false},
			texNames = {"egx2"},
			texList = {{"tex/AG_Systems1-7.png", "sTex0", "dxt3"}},
			settings = {{"fDivImg", {7,1}}, {"fMovSpeed", 0.1}, {"bImgInv", false}, {"fTransFac", -2}, {"iEffectID", 3}, 
				{"fNumberBinds", 5}, {"gColorMult", 0.9}, {"bZWrite", true}, {"fCullMode", 1}}
		},
		{
			shader = {"fx/billboard.fx", 2, false},
			texNames = {"billboard7"},
			texList = {{"tex/Piranha_1-9.png", "sTex0", "dxt3"}},
			settings = {{"fDivImg", {3,3}}, {"fMovSpeed", 0.2}, {"bImgInv", false}, {"fTransFac", 2}, {"iEffectID", 2}, 
				{"gColorMult", 0.9}, {"bZWrite", true}, {"fCullMode", 1}}
		},
		{
			shader = {"fx/billboard.fx", 2, false},
			texNames = {"billboard8"},
			texList = {{"tex/Techdera_1-9.png", "sTex0", "dxt3"}},
			settings = {{"fDivImg", {3,3}}, {"fMovSpeed", 0.2}, {"bImgInv", false}, {"fTransFac", 2}, {"iEffectID", 2}, 
				{"gColorMult", 0.9}, {"bZWrite", true}, {"fCullMode", 1}}
		},
		{
			shader = {"fx/billboard.fx", 2, false},
			texNames = {"fesisar_2"},
			texList = {{"tex/Random_1-6.png", "sTex0", "dxt3"}},
			settings = {{"fDivImg", {3,2}}, {"fMovSpeed", 1}, {"bImgInv", false}, {"fTransFac", 1}, {"iEffectID", 2}, 
				{"gColorMult", 1}, {"bZWrite", true}, {"fCullMode", 1}}
		},		
		{
			shader = {"fx/billboard.fx", 2, false},
			texNames = {"feisar_1to2_ratio"},
			texList = {{"tex/Random_1-6.png", "sTex0", "dxt3"}},
			settings = {{"fDivImg",{3,2}}, {"fMovSpeed", 1}, {"bImgInv", false}, {"fTransFac", 1}, {"iEffectID", 2}, 
				{"gColorMult", 1}, {"bZWrite", true}, {"fCullMode", 1}}
		},
		{
			shader = {"fx/flipbookUV.fx", 2, false},
			texNames = {"ag_systems1"},
			texList = {{"tex/Multiadd1.png", "sTex0", "dxt3"}},
			settings = {{"fDivImg", {1,4}}, {"fMovSpeed", 0.125}, {"bImgInv", false}, 
				{"gColorMult", 0.8}, {"gUVSpeed", {1,0}}, {"bZWrite", true}, {"fCullMode", 1}}
		},
		{ 
			shader = {"fx/nightbox.fx", 1, false},
			texNames = {"skybox_tex"},
			texList = {{"tex/skybox.dds", "sSkyBoxTexture", "dxt1"}},
			settings = {{"gRotate", {0, 0, math.rad(90)}}, {"gAnimate", false},{"fCullMode", 2}}
		}
	}

switchShaders = false
function applyShaders()
	for shInst,shEntr in ipairs(shaderList) do
		shaderTable[shInst] = {}
		shaderTable[shInst].texture = {}
		shaderTable[shInst].shader = dxCreateShader(shEntr.shader[1],shEntr.shader[2],0,shEntr.shader[3])
		if not shaderTable[shInst].shader then switchShaders = false return end
		for appInst,appEntr in ipairs(shEntr.texNames) do			
			engineApplyShaderToWorldTexture(shaderTable[shInst].shader, appEntr)
		end
			
		for texInst,texEntr in ipairs(shEntr.texList) do		
			shaderTable[shInst].texture[texInst] = dxCreateTexture(texEntr[1],texEntr[3])
			dxSetShaderValue(shaderTable[shInst].shader,texEntr[2],shaderTable[shInst].texture[texInst])
		end			
		for setInst,setEntr in ipairs(shEntr.settings) do		
			dxSetShaderValue(shaderTable[shInst].shader,setEntr[1],setEntr[2])
		end	
	end
	switchShaders = true
	disableTexSwitch = false
	shaderTimer = setTimer ( disableTexFunction, 1000, 0)
end

local disableTexSwitch = false
function disableTexFunction()
	if not shaderTable[1].shader then return end
	local camX, camY, camZ = getCameraMatrix()
	if (camX > 0 and camX < 255) and (camY > -2522 and camY < -2080) then
		if not disableTexSwitch then
			--outputDebugString('disabled "wogreydefault_1" texture')
			engineApplyShaderToWorldTexture(shaderTable[1].shader, "wogreydefault_1")
			disableTexSwitch = true
		end
	else
		if disableTexSwitch then
			--outputDebugString('enabled "wogreydefault_1" texture')
			engineRemoveShaderFromWorldTexture(shaderTable[1].shader, "wogreydefault_1")
			disableTexSwitch = false
		end
	end
end

function removeShaders()
	if shaderTimer then
		killTimer(shaderTimer)
		shaderTimer = nil
	end
	disableTexSwitch = false
	for shInst,shEntr in ipairs(shaderList) do
		if shaderTable[shInst] then
			for appInst,appEntr in ipairs(shEntr.texNames) do			
				engineRemoveShaderFromWorldTexture(shaderTable[shInst].shader, appEntr)
			end	
			for texInst,texEntr in ipairs(shEntr.texList) do		
				if shaderTable[shInst].texture[texInst] then
					destroyElement(shaderTable[shInst].texture[texInst])
					shaderTable[shInst].texture[texInst] = nil
				end
			end
			if shaderTable[shInst].shader then
				destroyElement(shaderTable[shInst].shader)
				shaderTable[shInst].shader = nil
			end
			shaderTable[shInst] = nil
		end
	end
	switchShaders = false
end

local coronaTexture = nil
local coronaTable = {}

local coronaList = {
		{pos = {169.93, -2006.5, 2157}, size = 22, col = {39,225,126,225}, dBias = 1},
		{pos = {169.93, -2006.5, 2148}, size = 22, col = {39,225,126,225}, dBias = 1},
		{pos = {169.93, -2006.5, 2139}, size = 22, col = {39,225,126,225}, dBias = 1},
		{pos = {182.57, -2020.63, 2157}, size = 22, col = {39,225,126,225}, dBias = 1},
		{pos = {182.57, -2020.63, 2148}, size = 22, col = {39,225,126,225}, dBias = 1},
		{pos = {182.57, -2020.63, 2139}, size = 22, col = {39,225,126,225}, dBias = 1},
		{pos = {119.04, -2081.21, 2157}, size = 22, col = {39,225,126,225}, dBias = 1},
		{pos = {119.04, -2081.21, 2148}, size = 22, col = {39,225,126,225}, dBias = 1},
		{pos = {119.04, -2081.21, 2139}, size = 22, col = {39,225,126,225}, dBias = 1},

		{pos = {134.11, -2085.2, 2157}, size = 22, col = {39,225,126,225}, dBias = 1},
		{pos = {134.11, -2085.2, 2148}, size = 22, col = {39,225,126,225}, dBias = 1},
		{pos = {134.11, -2085.2, 2139}, size = 22, col = {39,225,126,225}, dBias = 1},
	
		{pos = {940.633, -2141, 2150}, size = 22, col = {255,255,255,225}, dBias = 1},
		{pos = {940.633, -2141, 2143.77}, size = 22, col = {255,255,255,225}, dBias = 1},
		{pos = {940.633, -2141, 2137.55}, size = 22, col = {255,255,255,225}, dBias = 1},

		{pos = {804.822, -1902.17, 2163.31}, size = 88, col = {255,25,25,225}, dBias = 8},
	
		{pos = {1029.413, -2071.24, 2128.82}, size = 18, col = {255,255,255,225}, dBias = 2},

		{pos = {775.33, -2060.44, 2146.97}, size = 33, col = {255,255,200,225}, dBias = 2},	
		{pos = {794.08, -2069.54, 2146.97}, size = 33, col = {255,255,200,225}, dBias = 2},
	
		{pos = {608.711, -1930.34, 2184.466}, size = 44, col = {255,255,255,225}, dBias = 8},

		{pos = {466.277, -2063.78, 2142}, size = 22, col = {54,232,245,225}, dBias = 1},
		{pos = {363.706, -2063.78, 2142}, size = 22, col = {54,232,245,225}, dBias = 1},
		{pos = {274.16, -2059.743, 2141.863}, size = 22, col = {54,232,245,225}, dBias = 1},
		{pos = {259.054, -2038.163, 2141.863}, size = 22, col = {54,232,245,225}, dBias = 1},
		{pos = {232.645, -2037.927, 2141.863}, size = 22, col = {54,232,245,225}, dBias = 1},

		{pos = {479.57, -2026.875, 2136.5}, size = 7, col = {255,255,255,225}, dBias = 0.5},
		{pos = {479.57, -2019.118, 2136.5}, size = 7, col = {255,255,255,225}, dBias = 0.5},
		{pos = {479.75, -2011.361, 2136.5}, size = 7, col = {255,255,255,225}, dBias = 0.5}		
	}
  
 
function applyCoronas()
	coronaTexture = DxTexture("tex/coronastar.png","dxt3")
	for coInst, coEntr in ipairs(coronaList) do
		coronaTable[coInst] = CMat3DCom: create()
		coronaTable[coInst]: setCorona(true)
		coronaTable[coInst]: setTexture(coronaTexture)
		coronaTable[coInst]: setPosition(Vector3(coEntr.pos[1], coEntr.pos[2], coEntr.pos[3], coEntr.pos[4]))
		coronaTable[coInst]: setColor(Vector3(coEntr.col[1], coEntr.col[2], coEntr.col[3], coEntr.col[4]))
		coronaTable[coInst]: setSize(Vector2(coEntr.size, coEntr.size))
		if coEntr.dBias then
			coronaTable[coInst]: setDepthBias(coEntr.dBias)
		end
	end
end

function removeCoronas()
	for coInst, coEntr in ipairs(coronaTable) do
		coronaTable[coInst]: destroy()
	end
	coronaTable = {}
	if isElement(coronaTexture) then
		coronaTexture: destroy()
		coronaTexture = nil
	end
end

addEventHandler("onClientPreRender", root, function()
	for coInst, coEntr in ipairs(coronaTable) do
		coronaTable[coInst]: draw()
	end
end
)


local nightBox = {model = nil, txd = nil, dff = {}}
function applySkybox()

	local cam_x,cam_y,cam_z = getElementPosition(getLocalPlayer()) -- 17057
	nightBox.model = createObject ( 16287, cam_x, cam_y, cam_z, 0, 0, 0, true )
	setElementAlpha( nightBox.model, 1 )

	nightBox.txd = engineLoadTXD('img/sphere.txd')	
	engineImportTXD(nightBox.txd, 16287)
	-- DFF
	nightBox.dff = engineLoadDFF('img/sphere.dff', 16287 )
			
	if nightBox.txd and nightBox.dff and nightBox.model then
		engineReplaceModel(nightBox.dff, 16287, false )
		addEventHandler ( "onClientPreRender", getRootElement (), renderSphere )
	end
end

function removeSkybox()
	if nightBox.txd and nightBox.dff and nightBox.model then
		removeEventHandler ( "onClientPreRender", getRootElement (), renderSphere )
		engineRestoreModel(16287)
	end
	if nightBox.txd then
		destroyElement(nightBox.txd)
		nightBox.txd = nil
	end
	if nightBox.dff then
		destroyElement(nightBox.dff)
		nightBox.dff = nil
	end
end
		
function renderSphere()
	if not nightBox.model then return end
	local cam_x, cam_y, cam_z, lx, ly, lz = getCameraMatrix()
	setElementPosition( nightBox.model, cam_x, cam_y, cam_z ,false )
end
